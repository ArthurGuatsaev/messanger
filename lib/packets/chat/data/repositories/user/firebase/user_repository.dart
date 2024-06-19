import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messanger/packets/chat/domain/models/user/user_model.dart';
import 'package:messanger/packets/chat/domain/repositories/base_user_repository.dart';

class FirebaseUserRepository extends BaseUserRepository {
  final db = FirebaseFirestore.instance.collection('users');
  // добавление нового юзера при регистрации
  @override
  Future<void> addUser(UserModel user) async {
    await db.doc(user.id).set(user.toMap());
    await db
        .doc('all_users')
        .set(user.toMapForUsers(), SetOptions(merge: true));
  }

  @override
  Future<Map<String, UserModel>> getAllUsers() async {
    final doc = await db.doc('all_users').get();
    final users = doc.data();
    return allUsers =
        users?.map((k, v) => MapEntry(k, UserModel.fromMap(v))) ?? {};
  }

// для получения уведомления о получении сообщения
  @override
  Future<void> setUpdateEvent(
      UserModel user, UserModel author, String messageId) async {
    final whoom = db.doc(user.id).collection('chats');
    final aut = db.doc(author.id).collection('chats');
    whoom.doc('need_update').set({'id': '${author.id}_$messageId'});
    aut.doc('need_update').set({'id': '${user.id}_$messageId'});
  }
}
