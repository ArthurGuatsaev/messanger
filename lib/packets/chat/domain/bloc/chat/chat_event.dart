part of 'chat_bloc.dart';

sealed class ChatEvent {}

class SentMessageEvent extends ChatEvent {
  final String? text;
  final Map<String, dynamic>? user;

  SentMessageEvent({this.text, required this.user});
}

class RecieveLastMessageEvent extends ChatEvent {
  final String id;

  RecieveLastMessageEvent({required this.id});
}

class RecievChatsEvent extends ChatEvent {}

class InitUpdateStreamEvent extends ChatEvent {}

class AddUserEvent extends ChatEvent {
  final UserModel user;

  AddUserEvent({required this.user});
}

class SetAllUsers extends ChatEvent {
  final bool? refresh;

  SetAllUsers({this.refresh});
}
