import 'dart:async';

import 'package:messanger/packets/chat/domain/models/message/message_model.dart';
import 'package:messanger/packets/chat/domain/models/user/user_model.dart';

abstract class BaseChatRepository {
  StreamController<int>? errorController;
  Stream<String>? needUpdateStream;
  Map<String, List<MessageModel>>? chat;
  Future<void> sentMessage(UserModel user, UserModel author, MessageModel mess);
  Future<Map<String, List<MessageModel>>> resieveChat(String me);
  Future<MessageModel> resieveLastMessage(
      String me, String user, String messageId);
  void initUpdateStream(String id);
  Future<void> removeUpdateEvent(UserModel me, String user);
}
