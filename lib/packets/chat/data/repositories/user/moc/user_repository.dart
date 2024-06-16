import 'package:messanger/packets/chat/domain/repositories/base_user_repository.dart';

class MocUserRepository extends BaseUserRepository {
  @override
  Future<void> getUser() async {
    // final def = UserModel(id: 'id', name: 'name', lastName: 'lastName');
    user = null;
  }

  @override
  Future<void> setUser(String name, String lastName) async {}
}
