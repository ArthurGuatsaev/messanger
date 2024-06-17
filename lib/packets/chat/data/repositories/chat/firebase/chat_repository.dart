import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messanger/packets/chat/domain/repositories/base_chat_repository.dart';
import 'package:messanger/packets/chat/domain/models/message_model.dart';
import 'package:messanger/packets/chat/domain/models/user_model.dart';

class FirebaseChatRepository extends BaseChatRepository {
  final db = FirebaseFirestore.instance.collection('users');

  /// добавляет usera после регистрации

  @override
  Future<void> sentMessage(
      UserModel user, UserModel author, MessageModel mess) async {
    final docUser = db.doc(user.id).collection('chats').doc(author.id);
    final aut = db.doc(author.id).collection('chats').doc(user.id);
    [docUser, aut].map((e) async {
      await e.set(mess.toFBMap(), SetOptions(merge: true));
    }).toList();
  }

  @override
  Future<void> resieveMessage(List<UserModel> users, String id) async {
    final collection = db.doc(id).collection('chats');
    Map<String, Stream<List<MessageModel>>> res = {};
    for (var i in users) {
      final value = collection.doc(i.id).snapshots().transform(
          StreamTransformer<DocumentSnapshot<Map<String, dynamic>>,
              List<MessageModel>>.fromHandlers(
        handleData: (data, sink) {
          if (data.data() != null) {
            final mess =
                MessageModel.fromFBToList(data.data() as Map<String, dynamic>);
            sink.add(mess.values.toList());
          }
        },
      ));
      res[i.id] = value;
    }
    myChats = res;
  }
}
