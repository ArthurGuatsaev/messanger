part of 'chat_bloc.dart';

sealed class ChatEvent {}

class SentMessageEvent extends ChatEvent {
  final String? text;
  final UserModel author;
  final UserModel user;

  SentMessageEvent({this.text, required this.author, required this.user});
}

class RecieveMessageEvent extends ChatEvent {}
