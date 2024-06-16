import 'package:messanger/service/chat/models/message_model.dart';
import 'package:messanger/service/user/domain/models/user_model.dart';

abstract class BaseChatRepository {
  Future<void> addUser(UserModel user);
  Future<void> sentMessage(UserModel user, UserModel author, MessageModel mess);
  Stream? myChats;
}
