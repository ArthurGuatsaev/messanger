import '../models/user_model.dart';

abstract class BaseUserRepository {
  UserModel? me;
  Stream<Map<String, UserModel>>? myUsers;
  Future<void> addUser(UserModel user);
  void setChatUserStream();
  Future<Map<String, UserModel>> getAllUsers();
  Future<void> saveChatUser(UserModel user, UserModel author);
}
