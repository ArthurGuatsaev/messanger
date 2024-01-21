import 'package:flutter/cupertino.dart';
import 'package:messanger/navigation/navigation_state.dart';
import 'router/delegate.dart';

class MyNavigatorManager {
  MyNavigatorManager._();
  static MyNavigatorManager instance = MyNavigatorManager._();
  final key = GlobalKey<NavigatorState>();
  static final MyRouterDelegate delegate = MyRouterDelegate.instance;
  NavigatorState? get nav => key.currentState;

  Future<void> simulatorPop() async {
    nav?.pop();
  }

  void pushAuth() {
    delegate.myNS = MyNavigationState.auth();
    delegate.notify();
  }

  void pushHome() {
    delegate.myNS = MyNavigationState.home();
    delegate.notify();
  }

  void pushChat() {
    delegate.myNS = MyNavigationState.chat();
    delegate.notify();
  }
}
