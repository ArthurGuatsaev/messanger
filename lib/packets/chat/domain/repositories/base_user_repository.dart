import '../models/user/user_model.dart';

abstract class BaseUserRepository {
  UserModel? me;
  Map<String, UserModel>? allUsers;
  Stream<Map<String, UserModel>>? myUsers;
  Future<void> addUser(UserModel user);
  Future<Map<String, UserModel>> getAllUsers();
  Future<void> setUpdateEvent(
      UserModel user, UserModel author, String messageId);
}
