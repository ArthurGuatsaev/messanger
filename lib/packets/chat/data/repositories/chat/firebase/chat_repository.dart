import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messanger/packets/chat/domain/repositories/base_chat_repository.dart';
import 'package:messanger/packets/chat/domain/models/message/message_model.dart';

import '../../../../domain/models/user/user_model.dart';

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
  Future<Map<String, List<MessageModel>>> resieveChat(String me) async {
    final database = await db.doc(me).collection('chats').get();
    chat = {};
    database.docs.map(
      (e) {
        if (e.id != 'need_update') {
          final massages =
              e.data().values.map((e) => MessageModel.fromMap(e)).toList();
          chat![e.id] = massages;
        }
      },
    ).toList();
    return chat ?? {};
  }

  @override
  Future<MessageModel> resieveLastMessage(
      String me, String user, String messageId) async {
    final database = await db.doc(me).collection('chats').doc(user).get();
    final map = (database.data() as Map<String, dynamic>)[messageId];
    final lastMessage = MessageModel.fromMap(map as Map<String, dynamic>);
    return lastMessage;
  }

  @override
  void initUpdateStream(String id) {
    needUpdateStream = db
        .doc(id)
        .collection('chats')
        .doc('need_update')
        .snapshots()
        .transform(StreamTransformer.fromHandlers(handleData: (data, sink) {
      print('$data');
      if (data.data() != null || data.data()!['id'] != '') {
        sink.add(data.data()!['id']);
      }
    }));
  }

  @override
  Future<void> removeUpdateEvent(UserModel me, String user) async {
    await db.doc(user).collection('chats').doc('need_update').delete();
    await db.doc(me.id).collection('chats').doc('need_update').delete();
  }
}
