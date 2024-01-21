import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messanger/auth/domain/model/user_model.dart';

import '../model/message_model.dart';

abstract class MessageRepository {
  Future<void> sentMessage(
      {required String user, required String me, required MessageModel mes});
  Stream<QuerySnapshot<Map<String, dynamic>>> allMessages();
}

class FirebaseMessage extends MessageRepository {
  final UserModel me;
  final FirebaseFirestore firebase;
  FirebaseMessage({required this.me}) : firebase = FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> allMessages() {
    return firebase
        .collection('users')
        .doc(me.id)
        .collection('chats')
        .snapshots();
  }

  @override
  Future<void> sentMessage({
    required String user,
    required String me,
    required MessageModel mes,
  }) async {
    await firebase
        .collection('users')
        .doc(user)
        .collection('chats')
        .doc(me)
        .set(mes.toMap());
  }
}
