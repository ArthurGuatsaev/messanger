import 'package:flutter/material.dart';

class MyNavigationState extends ChangeNotifier {
  MyNavigationState.home({this.home = true});
  MyNavigationState.chat({this.home = true, this.chat = true});
  MyNavigationState.auth({this.home = true, this.auth = true});
  bool home = false;
  bool chat = false;
  bool auth = false;
}
