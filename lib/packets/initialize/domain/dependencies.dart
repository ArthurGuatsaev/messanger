part of '../initialize.dart';

abstract interface class Dependencies {
  abstract final BaseUserRepository uR;
  abstract final BaseChatRepository cR;
  final Map<String, Object> context = {};
}

class MutableDependencies implements Dependencies {
  @override
  final Map<String, Object> context = {};
  @override
  late BaseUserRepository uR;
  @override
  late BaseChatRepository cR;

  Dependencies freeze() => UnmutableDependencies(
        uR: uR,
        cR: cR,
        context: context,
      );
}

final class UnmutableDependencies implements Dependencies {
  @override
  final BaseChatRepository cR;
  @override
  final BaseUserRepository uR;
  @override
  final Map<String, Object> context;
  const UnmutableDependencies({
    required this.uR,
    required this.cR,
    required this.context,
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

  static Dependencies of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<InheritedDependencies>()!
      .dependencies;
}
