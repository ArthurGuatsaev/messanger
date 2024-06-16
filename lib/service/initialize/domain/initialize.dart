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
  'database initialization': (dependencies, isT) async {
    final errorController = StreamController<MyExeption>();
    dependencies.context['error_controller'] = errorController;
    BaseDataBaseRepository database = DatabaseRepository();
    if (isT == true) database = MockDatabaseRepository();
    // await database.sharedPreferences.remove('privacy_accepted');
    // await database.sharedPreferences.remove('flow');
    final isFistOpen = await database.getAdsAppFirstOpen();
    final flow = await database.getFlow() ?? 'none';
    final oldFlow = await database.getOldForFlow2();
    final saveLocation = await database.getSaveLocation();
    final isPrivacyAccepted = await database.getPrivacyAccepted();
    final isHaveSubscription = await database.getHaveSubscription();
    dependencies.context['saved_flow'] = oldFlow == true ? 'flow2' : flow;
    dependencies.context['saved_location'] = saveLocation ?? -1;
    dependencies.context['isfirstOpen'] = isFistOpen ?? true;
    dependencies.context['isPrivacyAccepted'] = isPrivacyAccepted ?? false;
    dependencies.context['isHaveSubscription'] = isHaveSubscription ?? false;
    await database.setAdsAppFirstOpen();
    log('flow $flow oldFlow $oldFlow');
    dependencies.dR = database;
  },
  'ADS repository': (dependencies, isT) async {
    final isFirstOpen = dependencies.context['isfirstOpen'] as bool;
    final error = dependencies.context['error_controller']
        as StreamController<MyExeption>;
    final ads = AdsRepository(
        isFirstOpen: isFirstOpen, adsDisabled: false, errorController: error);
    if (isT == true) {
      dependencies.aR = ads;
      return;
    }
    final personal = await ads.requestIDFA() ?? false;
    await ads.init(personal);
    await ads.loadInterstitialAd();
    if (!isFirstOpen) await ads.loadOpenAd();
    await ads.loadRewardedAd();
    dependencies.aR = ads;
  },
  'firebase initialization': (dependencies, isT) async {
    BaseConfigRepository config = ConfigRepository();
    if (isT == true) config = MockFirebaseRepository();
    await config.init();
    final flow = config.getFlow();
    final servers = config.getOpenServers();
    final needAdsSFlow = config.getSFFirstOpenAds();
    final needAds = config.getFirstOpenAds();
    final watchServers = config.getunlockServers();
    final configDomens = config.getConfigDomens();
    final abTest = config.getABTest();
    final timeToInitial = config.getLocationStatusToInitial();
    if (dependencies.context['saved_flow'] == 'none') {
      dependencies.context['saved_flow'] = flow;
      await dependencies.dR.setFlow(flow);
    }
    dependencies.context['config_domens'] = configDomens;
    dependencies.context['open_servers'] = servers;
    dependencies.context['watch_servers'] = watchServers;
    dependencies.context['adsFirstOpenF2'] = needAds;
    dependencies.context['adsFirstOpenF1'] = needAdsSFlow;
    dependencies.context['ABTest'] = abTest;
    dependencies.context['time_to_initial'] = timeToInitial;
    dependencies.fR = config;
  },
  'subscription repository': (dependencies, isT) async {
    BaseSubscriptionRepository sub =
        SubscriptionRepository(database: dependencies.dR);
    sub.errorController = dependencies.context['error_controller']
        as StreamController<MyExeption>;
    if (isT == true) sub = MocSubRepository();
    await sub.isAvailable();
    await sub.loadingProducts();
    await sub.startSubListen();
    final database = dependencies.dR;
    final x = await database.getHaveSubscription();
    final isHave = sub.checkSubStatus(x);
    dependencies.aR.adsDisabled = isHave;
    dependencies.sR = sub;
  },
  'connection repository': (dependencies, isT) async {
    final connection = ConnectionVPNRepository();
    connection.errorController = dependencies.context['error_controller']
        as StreamController<MyExeption>;
    if (isT == true) {
      dependencies.cR = connection;
      return;
    }
    final status = await connection.statusVPN();
    connection.configDomens =
        dependencies.context['config_domens'] as List<String>;
    dependencies.context['status'] = status ?? 'disconnected';
    dependencies.cR = connection;
  },
  'location repository': (dependencies, isT) async {
    BaseLocationRepository location;
    final flow = dependencies.context['saved_flow'] as String;
    final time = dependencies.context['time_to_initial'] as int;
    location = LocationRepositoryFlow1();
    if (flow == 'flow2') location = LocationRepositoryFlow2();
    if (flow == 'flow3') location = LocationRepositoryFlow3(time);
    location.errorController = dependencies.context['error_controller']
        as StreamController<MyExeption>;
    await location.getLocations();
    location.changeOpenLocations(
      openServers: dependencies.context['open_servers'] as List<int>,
      watchServers: dependencies.context['watch_servers'] as List<int>,
      id: dependencies.context['saved_location'] as int,
      haveS: dependencies.sR.haveSubscription,
      isFirstOpen: dependencies.context['isfirstOpen'] as bool,
    );
    dependencies.lR = location;
  },
  'Navigation repository': (dependencies, isT) async {
    MyRouterDelegate.instance.param['privacy'] =
        dependencies.context['isPrivacyAccepted'] ?? false;
    MyRouterDelegate.instance.param['flow'] =
        dependencies.context['saved_flow'] ?? 'flow2';
    WidgetsBinding.instance.addObserver(MyObserver(ads: dependencies.aR));
  },
  'ads open load finish': (dependencies, isT) async {
    // нужно ли показывать рекламу при первом показе flow 1
    final adsFirstOpenF1 = dependencies.context['adsFirstOpenF1'] as bool;
    // нужно ли показывать рекламу при первом показе flow 2
    final adsFirstOpenF2 = dependencies.context['adsFirstOpenF2'] as bool;
    final flow = dependencies.context['saved_flow'] as String;
    final ads = dependencies.aR;
    ads.adsByFOpen = flow == 'flow1' ? adsFirstOpenF1 : adsFirstOpenF2;
    // показатель загруженности рекламы для первого показа при входе в app
    int isAdLoad = 0;
    while (isAdLoad < 20) {
      isAdLoad = ads.isOpenAdReady ? 20 : isAdLoad + 1;
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }
};

class MyObserver extends WidgetsBindingObserver {
  final BaseAdsRepository ads;

  MyObserver({required this.ads});
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (ads.isShowing) return;
    if (ads.adsDisabled) return;
    if (state == AppLifecycleState.resumed) await ads.showOpenAd();
    super.didChangeAppLifecycleState(state);
  }
}
