part of 'chat_bloc.dart';

class ChatState {
  final Map<String, List<MessageModel>> chats;
  final Map<String, UserModel> allUsers;
  final Map<String, UserModel> chatUsers;

  ChatState(
      {this.chats = const {},
      this.allUsers = const {},
      this.chatUsers = const {}});
  ChatState copyWith({
    Map<String, List<MessageModel>>? chats,
    Map<String, UserModel>? allUsers,
    Map<String, UserModel>? chatUsers,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      allUsers: allUsers ?? this.allUsers,
      chatUsers: chatUsers ?? this.chatUsers,
    );
  }
}
