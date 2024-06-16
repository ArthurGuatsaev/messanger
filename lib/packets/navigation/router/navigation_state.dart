part of '../router.dart';

class MyNavigationState extends ChangeNotifier {
  MyNavigationState.home({this.home = true});
  MyNavigationState.auth({this.auth = true});

  bool home = false;
  bool auth = false;
}
