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
    final user = param['user'] as Map<String, dynamic>?;
    return Navigator(
      key: navigatorKey,
      pages: [
        if (myNS == null) const MaterialPage(child: Scaffold()),
        if (myNS?.home == true) const MaterialPage(child: HomePage()),
        if (myNS?.auth == true) const MaterialPage(child: AuthPage()),
        if (myNS?.chat == true)
          MaterialPage(child: ChatPage(user: user), name: 'chat'),
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
      case 'chat':
        myNS = MyNavigationState.home();
        notifyListeners();
    }
    return false;
  }

  void notify() => notifyListeners();
}
