part of 'mess_bloc.dart';

abstract class MessEvent {}

class SendMessageEvent extends MessEvent {
  final String mess;

  SendMessageEvent({required this.mess});
}

class GetChatEvent extends MessEvent {
  final String collection;

  GetChatEvent({required this.collection});
}

class GetUsersEvent extends MessEvent {}

class SendAudioEvent extends MessEvent {
  final File file;

  SendAudioEvent({required this.file});
}

class ChangeCurrentEvent extends MessEvent {
  final String current;

  ChangeCurrentEvent({required this.current});
}
