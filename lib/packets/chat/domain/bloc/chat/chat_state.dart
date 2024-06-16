part of 'chat_bloc.dart';

class ChatState {
  final Map<String, List<MessageModel>> chats;
  final Map<String, UserModel> allUsers;

  ChatState({this.chats = const {}, this.allUsers = const {}});
  ChatState copyWith({
    Map<String, List<MessageModel>>? chats,
    Map<String, UserModel>? allUsers,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      allUsers: allUsers ?? this.allUsers,
    );
  }
}
