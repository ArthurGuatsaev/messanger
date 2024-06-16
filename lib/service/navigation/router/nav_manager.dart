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
    delegate.param['needAdsFirstOpen'] = null;
    delegate.myNS = MyNavigationState.home();
    delegate.notify();
  }

  void pushHomeAfterSubscribe() {
    if (delegate.myNS != MyNavigationState.sub() ||
        delegate.myNS != MyNavigationState.subHome()) return;
    delegate.param['needAdsFirstOpen'] = null;
    delegate.myNS = MyNavigationState.home();
    delegate.notify();
  }

  void pushLocation() {
    delegate.myNS = MyNavigationState.locations();
    delegate.notify();
  }

  void pushAboutUs() {
    delegate.myNS = MyNavigationState.aboutUs();
    delegate.notify();
  }

  void pushContacts() {
    delegate.myNS = MyNavigationState.contacts();
    delegate.notify();
  }

  void pushLogs() {
    delegate.param['logPath'] = 'logPath';
    delegate.myNS = MyNavigationState.logs();
    delegate.notify();
  }

  void pushLogsError() {
    delegate.param['logPath'] = 'last-error';
    delegate.myNS = MyNavigationState.logs();
    delegate.notify();
  }

  void pushBoard() {
    delegate.myNS = MyNavigationState.board();
    delegate.notify();
  }

  void pushSub() {
    delegate.myNS = MyNavigationState.sub();
    delegate.notify();
  }

  void pushSubHome() {
    delegate.param['needAdsFirstOpen'] = false;
    delegate.myNS = MyNavigationState.subHome();
    delegate.notify();
  }
}
