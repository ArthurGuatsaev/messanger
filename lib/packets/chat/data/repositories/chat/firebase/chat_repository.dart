import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messanger/packets/chat/domain/repositories/base_chat_repository.dart';
import 'package:messanger/packets/chat/domain/models/message_model.dart';
import 'package:messanger/packets/chat/domain/models/user_model.dart';

class FirebaseChatRepository extends BaseChatRepository {
  final db = FirebaseFirestore.instance.collection('users');
  @override
  Future<void> addUser(UserModel user) async {
    await db.doc(user.id).set(user.toMap());
  }

  @override
  Future<void> sentMessage(
      UserModel user, UserModel author, MessageModel mess) async {
    final docUser = db.doc(user.id).collection('chats').doc(author.id);
    final authorUser = db.doc(author.id).collection('chats').doc(user.id);
    [docUser, authorUser].map((e) async {
      await e.update({
        "messages": FieldValue.arrayUnion([mess.toMap()])
      }).onError((error, stackTrace) => errorController?.add(111));
    }).toList();
  }

  @override
  Future<void> getMyChats(String? id) async {
    if (id == null) return;
    final collection = db.doc(id).collection('chats');
    final users = await collection.get();
    Map<String, Stream<MessageModel>> res = {};
    for (var i in users.docs) {
      final name = i.data()['name'];
      final lastName = i.data()['lastName'];
      final value = collection.doc(i.id).snapshots().transform(
              StreamTransformer<DocumentSnapshot<Map<String, dynamic>>,
                  MessageModel>.fromHandlers(
            handleData: (data, sink) =>
                sink.add(MessageModel.fromMap(data.data()!)),
          ));
      res['$name $lastName'] = value;
    }
    myChats = res;
  }
}
