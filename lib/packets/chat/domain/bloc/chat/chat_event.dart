part of 'chat_bloc.dart';

sealed class ChatEvent {}

class SentMessageEvent extends ChatEvent {
  final String? text;
  final Map<String, dynamic>? user;

  SentMessageEvent({this.text, required this.user});
}

class RecieveMessageEvent extends ChatEvent {
  final Map<String, UserModel> users;

  RecieveMessageEvent({required this.users});
}

class AddUserEvent extends ChatEvent {
  final UserModel user;

  AddUserEvent({required this.user});
}

class SetAllUsers extends ChatEvent {
  final bool? empty;

  SetAllUsers({this.empty});
}
