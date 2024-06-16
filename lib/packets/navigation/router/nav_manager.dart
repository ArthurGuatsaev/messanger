part of '../router.dart';

class MyNavigatorManager {
  MyNavigatorManager._();
  static MyNavigatorManager instance = MyNavigatorManager._();
  final key = GlobalKey<NavigatorState>();
  static final MyRouterDelegate delegate = MyRouterDelegate.instance;
  NavigatorState? get nav => key.currentState;

  Future<void> simulatorPop() async {
    nav?.pop();
  }

  void pushHome() {
    delegate.myNS = MyNavigationState.home();
    delegate.notify();
  }
}
