// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mess_bloc.dart';

class MessState {
  final Map<String, List<MessageModel>> chats;
  final String current;

  const MessState({this.chats = const {}, this.current = ''});

  MessState copyWith({
    Map<String, List<MessageModel>>? chats,
    String? current,
  }) {
    return MessState(
      chats: chats ?? this.chats,
      current: current ?? this.current,
    );
  }
}
