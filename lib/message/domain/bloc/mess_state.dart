// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mess_bloc.dart';

class MessState {
  final Map<String, ChatModel> chats;
  final String current;
  final List<UserModel> users;
  const MessState(
      {this.chats = const {}, this.current = '', this.users = const []});

  MessState copyWith({
    Map<String, ChatModel>? chats,
    String? current,
    List<UserModel>? users,
  }) {
    return MessState(
      chats: chats ?? this.chats,
      current: current ?? this.current,
      users: users ?? this.users,
    );
  }

  ChatModel get curList {
    if (chats[current] == null) return ChatModel(messages: []);
    return chats[current]!;
  }

  String correspondentName(String id) {
    if (users.isEmpty) return '';
    return users.where((element) => element.id == id).first.name;
  }
}
