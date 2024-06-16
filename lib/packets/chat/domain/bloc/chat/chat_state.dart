part of 'chat_bloc.dart';

class ChatState {
  final Map<String, List<MessageModel>> chats;

  ChatState({this.chats = const {}});
  ChatState copyWith({
    Map<String, List<MessageModel>>? chats,
  }) {
    return ChatState(chats: chats ?? this.chats);
  }
}
