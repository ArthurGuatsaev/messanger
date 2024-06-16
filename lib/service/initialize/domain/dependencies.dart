part of '../initialize.dart';

abstract interface class Dependencies {
  abstract final BaseDataBaseRepository dR;
  abstract final BaseConnectiionVPNRepository cR;
  abstract final BaseLocationRepository lR;
  abstract final BaseAdsRepository aR;
  abstract final BaseConfigRepository fR;
  abstract final BaseSubscriptionRepository sR;
  final Map<String, Object> context = {};
}

class MutableDependencies implements Dependencies {
  @override
  final Map<String, Object> context = {};
  @override
  late BaseDataBaseRepository dR;
  @override
  late BaseConnectiionVPNRepository cR;
  @override
  late BaseLocationRepository lR;
  @override
  late BaseAdsRepository aR;
  @override
  late BaseConfigRepository fR;
  @override
  late BaseSubscriptionRepository sR;

  Dependencies freeze() => UnmutableDependencies(
        aR: aR,
        dR: dR,
        cR: cR,
        fR: fR,
        lR: lR,
        sR: sR,
        context: context,
      );
}

final class UnmutableDependencies implements Dependencies {
  @override
  final BaseDataBaseRepository dR;
  @override
  final BaseConnectiionVPNRepository cR;
  @override
  final BaseLocationRepository lR;
  @override
  final BaseAdsRepository aR;
  @override
  final BaseConfigRepository fR;
  @override
  final BaseSubscriptionRepository sR;
  @override
  final Map<String, Object> context;
  const UnmutableDependencies({
    required this.dR,
    required this.cR,
    required this.lR,
    required this.aR,
    required this.fR,
    required this.sR,
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
