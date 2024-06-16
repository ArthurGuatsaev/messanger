part of '../router.dart';

class MyRouterDelegate extends RouterDelegate<MyNavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyNavigationState> {
  static MyRouterDelegate instance = MyRouterDelegate._();
  Map<String, Object?> param = {};
  MyNavigationState? myNS;
  @override
  final GlobalKey<NavigatorState> navigatorKey =
      MyNavigatorManager.instance.key;
  MyRouterDelegate._();
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (myNS == null) const MaterialPage(child: Scaffold()),
      ],
      onPopPage: onPop,
    );
  }

  @override
  MyNavigationState? get currentConfiguration => myNS;
  @override
  Future<void> setNewRoutePath(MyNavigationState configuration) async {
    myNS = configuration;
    notifyListeners();
  }

  @override
  Future<void> setInitialRoutePath(MyNavigationState configuration) async {
    if (param['isAuth'] == true) {
      Future.sync(() => myNS = MyNavigationState.home());
    } else {
      Future.sync(() => myNS = MyNavigationState.auth());
    }
  }

  bool onPop(Route<dynamic> route, dynamic result) {
    switch (route.settings.name) {
      case 'sub':
        myNS = MyNavigationState.home();
        notifyListeners();
    }
    return false;
  }

  void notify() => notifyListeners();
}
