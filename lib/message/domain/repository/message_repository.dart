import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:messanger/auth/domain/model/user_model.dart';

import '../model/message_model.dart';

abstract class MessageRepository {
  Future<void> sentMessage({
    required String user,
    required ChatModel mes,
    required String me,
  });
  Stream<QuerySnapshot<Map<String, dynamic>>> allMessages(String col);
  Stream<QuerySnapshot<Map<String, dynamic>>> allUsers();
}

class FirebaseMessage extends MessageRepository {
  final UserModel me;
  final FirebaseFirestore firebase;
  final FirebaseStorage storage;
  FirebaseMessage({required this.me})
      : firebase = FirebaseFirestore.instance,
        storage = FirebaseStorage.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> allMessages(String col) {
    return firebase
        .collection('users')
        .doc(col)
        .collection('chats')
        .snapshots();
  }

  @override
  Future<void> sentMessage({
    required String user,
    required ChatModel mes,
    required String me,
  }) async {
    final message = mes.toMap();
    await firebase
        .collection('users')
        .doc(user)
        .collection('chats')
        .doc(me)
        .set(message);
    await firebase
        .collection('users')
        .doc(me)
        .collection('chats')
        .doc(user)
        .set(message);
  }

  Future<void> sendAudio(
      File file, String user, ChatModel chat, UserModel me) async {
    final storageRef = storage.ref();
    final path = storageRef.child('$user.mp4');
    final url = await path.getDownloadURL();
    path.putFile(file);
    final mes = MessageModel.audio(d: DateTime.now(), nam: me.name, aud: url);
    chat.messages.add(mes);
    await sentMessage(user: user, mes: chat, me: me.id);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> allUsers() {
    return firebase.collection('allusers').snapshots();
  }
}
