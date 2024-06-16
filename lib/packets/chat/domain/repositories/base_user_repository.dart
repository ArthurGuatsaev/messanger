import '../models/user_model.dart';

abstract class BaseUserRepository {
  String? myId;
  Stream<List<String>>? myUsers;
  Future<void> addUser(UserModel user);
  void getMyUsers();
  Future<Map<String, UserModel>> getAllUsers();
  Future<void> saveMyUser(UserModel user, UserModel author);
}
