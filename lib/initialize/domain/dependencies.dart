part of '../initialize.dart';

abstract interface class Dependencies {
  abstract final MessageRepository messageRepository;
  abstract final UserRepository userRepository;
  abstract final AuthCubit auth;
  abstract final MessBloc mess;
}

class MutableDependencies implements Dependencies {
  final Map<String, Object> context = {};
  @override
  late MessageRepository messageRepository;
  @override
  late AuthCubit auth;
  @override
  late MessBloc mess;
  @override
  late UserRepository userRepository;

  Dependencies freeze() => UnmutableDependencies(
      messageRepository: messageRepository,
      userRepository: userRepository,
      auth: auth,
      mess: mess);
}

final class UnmutableDependencies implements Dependencies {
  @override
  final MessageRepository messageRepository;
  @override
  final AuthCubit auth;
  @override
  final MessBloc mess;
  @override
  final UserRepository userRepository;

  const UnmutableDependencies({
    required this.messageRepository,
    required this.userRepository,
    required this.auth,
    required this.mess,
  });
}

class InheritedDependencies extends InheritedWidget {
  final Dependencies dependencies;
  const InheritedDependencies({
    required super.child,
    super.key,
    required this.dependencies,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
