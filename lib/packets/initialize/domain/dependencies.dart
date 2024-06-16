part of '../initialize.dart';

abstract interface class Dependencies {
  abstract final BaseAuthRepository aR;
  abstract final BaseChatRepository cR;
  abstract final BaseUserRepository uR;
  final Map<String, Object> context = {};
}

class MutableDependencies implements Dependencies {
  @override
  final Map<String, Object> context = {};
  @override
  late BaseAuthRepository aR;
  @override
  late BaseChatRepository cR;
  @override
  late BaseUserRepository uR;

  Dependencies freeze() => UnmutableDependencies(
        aR: aR,
        cR: cR,
        uR: uR,
        context: context,
      );
}

final class UnmutableDependencies implements Dependencies {
  @override
  final BaseChatRepository cR;
  @override
  final BaseAuthRepository aR;
  @override
  final BaseUserRepository uR;
  @override
  final Map<String, Object> context;
  const UnmutableDependencies({
    required this.aR,
    required this.cR,
    required this.uR,
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
