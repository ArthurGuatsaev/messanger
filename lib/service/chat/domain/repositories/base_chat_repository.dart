import 'dart:async';

import 'package:messanger/service/chat/models/message_model.dart';
import 'package:messanger/service/chat/models/user_model.dart';

abstract class BaseChatRepository {
  StreamController<int>? errorController;
  Map<String, Stream<MessageModel>>? myChats;
  Future<void> addUser(UserModel user);
  Future<void> sentMessage(UserModel user, UserModel author, MessageModel mess);
  Future<void> getMyChats(String? id);
}
