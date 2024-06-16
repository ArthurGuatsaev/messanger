import 'package:messanger/service/chat/domain/repositories/base_chat_repository.dart';
import 'package:messanger/service/chat/models/message_model.dart';
import 'package:messanger/service/chat/models/user_model.dart';

class FirebaseChatRepository extends BaseChatRepository {
  @override
  Future<void> addUser(UserModel user) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<void> sentMessage(
      UserModel user, UserModel author, MessageModel mess) {
    // TODO: implement sentMessage
    throw UnimplementedError();
  }
}
