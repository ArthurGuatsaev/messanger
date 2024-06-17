part of '../router.dart';

class MyNavigationState extends ChangeNotifier {
  MyNavigationState.home({this.home = true});
  MyNavigationState.auth({this.auth = true});
  MyNavigationState.chat({this.chat = true, this.home = true});

  bool home = false;
  bool auth = false;
  bool chat = false;
}
