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
  'users initialization': (dependencies, isT) async {
    final errorController = StreamController<int>();
    BaseUserRepository userR = SharedUserRepository();
    if (isT == true) userR = MocUserRepository();
    userR.errorController = errorController;
    dependencies.uR = userR;
  },
  'chats initialization': (dependencies, isT) async {
    BaseChatRepository chatsR = FirebaseChatRepository();
    if (isT == true) return;
    final userR = dependencies.uR;
    chatsR.errorController = userR.errorController;
    chatsR.getMyChats(userR.user?.id);
    dependencies.cR = chatsR;
  },
  'navigation': (dependencies, isT) {
    MyRouterDelegate.instance.param['isAuth'] = dependencies.uR.user != null;
  }
};
