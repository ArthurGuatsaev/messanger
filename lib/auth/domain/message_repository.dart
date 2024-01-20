abstract class MessageRepository {
  Future<void> sentMessage();
  Stream allMessages();
}

class FirebaseMessage extends MessageRepository {
  @override
  Stream allMessages() {
    // TODO: implement allMessages
    throw UnimplementedError();
  }

  @override
  Future<void> sentMessage() {
    // TODO: implement sentMessage
    throw UnimplementedError();
  }
}
