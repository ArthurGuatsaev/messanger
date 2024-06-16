import 'dart:async';

import 'package:messanger/packets/chat/domain/models/user_model.dart';

abstract class BaseUserRepository {
  StreamController<int>? errorController;
  UserModel? user;
  Future<void> setUser(String name, String lastName);
  Future<void> getUser();
}
