import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messanger/packets/chat/domain/models/user_model.dart';
import 'package:messanger/packets/chat/domain/repositories/base_user_repository.dart';

class FirebaseUserRepository extends BaseUserRepository {
  final db = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addUser(UserModel user) async {
    await db.doc(user.id).set(user.toMap());
    await db
        .doc('all_users')
        .set(user.toMapForUsers(), SetOptions(merge: true));
  }

  @override
  void setChatUserStream() {
    final snap =
        db.doc(me?.id).collection('chats').doc('chat_users').snapshots();
    myUsers = snap.transform(StreamTransformer<
        DocumentSnapshot<Map<String, dynamic>>,
        Map<String, UserModel>>.fromHandlers(
      handleData: (data, sink) {
        if (data.data() != null) {
          final us =
              data.data()?.map((k, v) => MapEntry(k, UserModel.fromMap(v)));
          sink.add(us!);
        }
      },
    ));
  }

  @override
  Future<Map<String, UserModel>> getAllUsers() async {
    final doc = await db.doc('all_users').get();
    final users = doc.data();
    return users?.map((k, v) => MapEntry(k, UserModel.fromMap(v))) ?? {};
  }

  @override
  Future<void> saveChatUser(UserModel user, UserModel author) async {
    final whoom = db.doc(user.id).collection('chats');
    final aut = db.doc(author.id).collection('chats');
    whoom
        .doc('chat_users')
        .set(author.toMapForUsers(), SetOptions(merge: true));
    aut.doc('chat_users').set(user.toMapForUsers(), SetOptions(merge: true));
  }
}
