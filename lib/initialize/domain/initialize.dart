part of '../initialize.dart';

Future<Dependencies> $initializeDependencies(
    {Function(int progress, String message)? onProgress}) async {
  final dependencies = MutableDependencies();
  final totalStaps = _initializationSteps.length;
  var currentStep = 0;
  for (final step in _initializationSteps.entries) {
    currentStep++;
    final percent = (currentStep * 100 ~/ totalStaps).clamp(0, 100);
    onProgress?.call(percent, step.key);
    await step.value(dependencies);
    log('initialization: $currentStep/$totalStaps ($percent) | ${step.key}');
  }
  return dependencies.freeze();
}

typedef _InitializationStep = FutureOr<void> Function(
    MutableDependencies dependencies);
final Map<String, _InitializationStep> _initializationSteps =
    <String, _InitializationStep>{
  'User repository': (dependencies) async {
    final userR = UserRepository();
    await userR.reset();
    final key = await userR.getKey();
    if (key == null) {
      dependencies.userRepository = userR;
    } else {
      await userR.getUser(key);
      dependencies.userRepository = userR;
    }
  },
  'Message repository': (dependencies) {
    final message = FirebaseMessage(me: dependencies.userRepository.user);
    dependencies.messageRepository = message;
  },
  'Auth': (dependencies) {
    final auth = AuthCubit(repo: dependencies.userRepository);
    dependencies.auth = auth;
  },
  'Mess': (dependencies) {
    final mess =
        MessBloc(repo: dependencies.messageRepository, auth: dependencies.auth)
          ..add(GetUsersEvent())
          ..add(GetChatEvent(collection: dependencies.userRepository.user.id));

    dependencies.mess = mess;
  },
  'Delegate initialization': (dependencies) {
    MyNavigatorManager.delegate.auth =
        dependencies.userRepository.user.name == 'unknown';
  },
};
