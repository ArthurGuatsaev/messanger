import 'dart:async';

import 'package:messanger/service/user/domain/models/user_model.dart';

abstract class BaseLocalUserRepository {
  StreamController<int>? errorController;
  UserModel? user;
  Future<void> setUser(String name, String lastName);
  Future<void> getUser();
}
