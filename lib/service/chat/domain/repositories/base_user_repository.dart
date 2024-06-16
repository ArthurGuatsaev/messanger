import 'dart:async';

import 'package:messanger/service/chat/models/user_model.dart';

abstract class BaseUserRepository {
  StreamController<int>? errorController;
  UserModel? user;
  Future<void> setUser(String name, String lastName);
  Future<void> getUser();
}
