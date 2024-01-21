part of '../initialize.dart';

abstract interface class Dependencies {
  abstract final MessageRepository messageRepository;
  abstract final UserRepository userRepository;
}

class MutableDependencies implements Dependencies {
  final Map<String, Object> context = {};
  @override
  late MessageRepository messageRepository;
  @override
  late UserRepository userRepository;

  Dependencies freeze() => UnmutableDependencies(
        messageRepository: messageRepository,
        userRepository: userRepository,
      );
}

final class UnmutableDependencies implements Dependencies {
  @override
  final MessageRepository messageRepository;
  @override
  final UserRepository userRepository;

  const UnmutableDependencies({
    required this.messageRepository,
    required this.userRepository,
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
