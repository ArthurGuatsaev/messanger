part of 'mess_bloc.dart';

abstract class MessEvent {}

class SendMessageEvent extends MessEvent {
  final MessageModel mess;
  final String me;
  final String user;

  SendMessageEvent({required this.mess, required this.me, required this.user});
}

class GetChatEvent extends MessEvent {}

class ChangeCurrentEvent extends MessEvent {
  final String current;

  ChangeCurrentEvent({required this.current});
}
