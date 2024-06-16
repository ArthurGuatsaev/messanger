import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messanger/packets/chat/domain/models/user_model.dart';
import 'package:messanger/packets/chat/domain/repositories/base_user_repository.dart';

class FirebaseUserRepository extends BaseUserRepository {
  final db = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addUser(UserModel user) async {
    await db.doc(user.id).set(user.toMap());
    await db.doc('all_users').update({
      "messages": FieldValue.arrayUnion([user.toMap()])
    });
  }

  @override
  void getMyUsers() {
    final snap = db.doc(myId).collection('chats').doc('chat_users').snapshots();
    myUsers = snap.transform(StreamTransformer<
        DocumentSnapshot<Map<String, dynamic>>, List<String>>.fromHandlers(
      handleData: (data, sink) => sink.add(
          (data.data()!['users'] as List).map((e) => e as String).toList()),
    ));
  }

  @override
  Future<Map<String, UserModel>> getAllUsers() async {
    final doc = await db.doc('all_users').get();
    final users = doc.data()?['users'] as List<Map<String, dynamic>>;
    final rs = <String, UserModel>{};
    for (var i in users) {
      final user = UserModel.fromMap(i);
      rs[user.id] = user;
    }
    return rs;
  }

  @override
  Future<void> saveMyUser(UserModel user, UserModel author) async {
    final whoom = db.doc(user.id).collection('chats');
    final aut = db.doc(author.id).collection('chats');
    whoom.doc('chat_users').update({
      "users": FieldValue.arrayUnion([author.toMap()])
    });
    aut.doc('chat_users').update({
      "users": FieldValue.arrayUnion([user.toMap()])
    });
  }
}
