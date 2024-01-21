import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messanger/auth/domain/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/initial_data.dart';

class UserRepository {
  UserModel user = UserModel(name: 'unknown', id: 'id');
  final FirebaseFirestore firebase;
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();
  UserRepository() : firebase = FirebaseFirestore.instance;
  Future<void> getUser(String key) async {
    await firebase.collection('users').doc(key).get().then((value) {
      if (value.data() == null) user = UserModel(name: 'unknown', id: 'id');
      user = UserModel.fromMap(value.data()!);
    });
  }

  Future<String?> getKey() async {
    return (await prefs).getString('name');
  }

  Future<void> reset() async {
    (await prefs).remove('name');
  }

  Future<void> setKey(String name) async {
    (await prefs).setString('name', name);
  }

  Future<UserModel> setUser(String name) async {
    final id = '$name${DateTime.now().microsecond}';
    await setKey(id);
    await firebase
        .collection('users')
        .doc(id)
        .set(UserModel(name: name, id: id).toMap());
    await firebase
        .collection('allusers')
        .doc(id)
        .set(UserModel(name: name, id: id).toMap());
    await firebase
        .collection('users')
        .doc(id)
        .collection('chats')
        .doc(AG.id)
        .set(AGM);
    return UserModel(name: name, id: id);
  }
}
