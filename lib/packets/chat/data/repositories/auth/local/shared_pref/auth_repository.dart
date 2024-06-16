import 'package:messanger/packets/chat/domain/models/user_model.dart';
import 'package:messanger/packets/chat/domain/repositories/base_auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedAuthRepository extends BaseAuthRepository {
  SharedPreferences? _shared;
  Future<SharedPreferences> get shared async {
    if (_shared != null) return _shared!;
    return _shared = await SharedPreferences.getInstance();
  }

  @override
  Future<void> getUser() async {
    final data = (await shared).getString('saved_user')?.split('_');
    if (data == null) return;
    user = UserModel(id: data.last, name: data.first, lastName: data[2]);
  }

  @override
  Future<void> setUser(String name, String lastName) async {
    final id = DateTime.now().millisecondsSinceEpoch;
    (await shared).setString('saved_user', '${name}_${lastName}_$id');
  }
}
