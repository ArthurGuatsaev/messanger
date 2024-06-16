part of '../initialize.dart';

Future<Dependencies> $initializeDependencies(
    {Function(int progress, String message)? onProgress,
    bool? isTesting}) async {
  final dependencies = MutableDependencies();
  final totalStaps = _initializationSteps.length;
  var currentStep = 0;
  for (final step in _initializationSteps.entries) {
    currentStep++;
    final percent = (currentStep * 100 ~/ totalStaps).clamp(0, 100);
    onProgress?.call(percent, step.key);
    await step.value(dependencies, isTesting);
    log('initialization: $currentStep/$totalStaps ($percent) | ${step.key}');
  }
  return dependencies.freeze();
}

typedef _InitializationStep = FutureOr<void> Function(
    MutableDependencies dependencies, bool? isT);
final Map<String, _InitializationStep> _initializationSteps =
    <String, _InitializationStep>{
  'Auth initialization': (dependencies, isT) async {
    final errorController = StreamController<int>();
    BaseAuthRepository userR = SharedAuthRepository();
    if (isT == true) userR = MocAuthRepository();
    userR.errorController = errorController;
    dependencies.aR = userR;
  },
  'User initialization': (dependencies, isT) async {
    BaseUserRepository userR = FirebaseUserRepository();
    if (isT == true) return;
    final authR = dependencies.aR;
    userR.myId = authR.user?.id;
    if (authR.user != null) userR.getMyUsers();
    dependencies.uR = userR;
  },
  'Chats initialization': (dependencies, isT) async {
    BaseChatRepository chatsR = FirebaseChatRepository();
    if (isT == true) return;
    final userR = dependencies.aR;
    chatsR.errorController = userR.errorController;
    dependencies.cR = chatsR;
  },
  'navigation': (dependencies, isT) {
    MyRouterDelegate.instance.param['isAuth'] = dependencies.aR.user != null;
  }
};
