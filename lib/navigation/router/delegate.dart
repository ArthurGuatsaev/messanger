import 'package:flutter/material.dart';
import 'package:messanger/auth/view/auth_page.dart';
import 'package:messanger/pages/chat.dart';
import 'package:messanger/pages/home.dart';
import '../nav_manager.dart';
import '../navigation_state.dart';

class MyRouterDelegate extends RouterDelegate<MyNavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyNavigationState> {
  static MyRouterDelegate instance = MyRouterDelegate._();
  MyNavigationState? myNS;
  bool auth = false;
  @override
  final GlobalKey<NavigatorState> navigatorKey =
      MyNavigatorManager.instance.key;
  MyRouterDelegate._();
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        const MaterialPage(child: HomePage()),
        if (myNS?.chat == true)
          const MaterialPage(child: ChatPage(), name: 'chat'),
        if (myNS?.auth == true)
          const MaterialPage(child: AuthPage(), name: 'auth'),
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
    if (!auth) myNS = MyNavigationState.home();
    if (auth) myNS = MyNavigationState.auth();
    notifyListeners();
  }

  bool onPop(Route<dynamic> route, dynamic result) {
    switch (route.settings.name) {
      case 'chat':
      case 'auth':
        myNS = MyNavigationState.home();
        notifyListeners();
    }
    return false;
  }

  void notify() => notifyListeners();
}
