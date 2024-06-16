part of '../router.dart';

class MyNavigationState extends ChangeNotifier {
  MyNavigationState.home({this.home = true});
  MyNavigationState.locations({this.home = true, this.locations = true});
  MyNavigationState.aboutUs({this.home = true, this.aboutUs = true});
  MyNavigationState.contacts({this.home = true, this.contacts = true});
  MyNavigationState.logs({this.home = true, this.logs = true});
  MyNavigationState.privacy({this.privacy = true});
  MyNavigationState.board({this.board = true});
  MyNavigationState.sub({this.sub = true});
  MyNavigationState.subHome({this.sub = true, this.home = true});

  bool home = false;
  bool locations = false;
  bool privacy = false;
  bool aboutUs = false;
  bool contacts = false;
  bool logs = false;
  bool board = false;
  bool sub = false;
}
