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
      await e.update({
        "messages": FieldValue.arrayUnion([mess.toMap()])
      }).onError((error, stackTrace) => errorController?.add(111));
    }).toList();
  }

  @override
  Future<void> resieveMessage(
      List<String> users, String id, Map<String, UserModel> allUsers) async {
    final collection = db.doc(id).collection('chats');
    Map<String, Stream<List<MessageModel>>> res = {};
    for (var i in users) {
      final user = allUsers[i];
      final value = collection.doc(user?.id).snapshots().transform(
              StreamTransformer<DocumentSnapshot<Map<String, dynamic>>,
                  List<MessageModel>>.fromHandlers(
            handleData: (data, sink) => sink.add(
                (data.data() as List<Map<String, dynamic>>)
                    .map((e) => MessageModel.fromMap(e))
                    .toList()),
          ));
      res['${user?.name} ${user?.lastName}'] = value;
    }
    myChats = res;
  }
}
