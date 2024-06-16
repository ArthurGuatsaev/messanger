import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:messanger/packets/chat/domain/models/message_model.dart';
import 'package:messanger/packets/chat/domain/models/user_model.dart';
import 'package:messanger/packets/chat/domain/repositories/base_chat_repository.dart';
import 'package:messanger/packets/chat/domain/repositories/base_user_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final BaseChatRepository _chatR;
  final BaseUserRepository _userR;
  StreamSubscription? subscription;
  ChatBloc(
      {required BaseChatRepository chatR, required BaseUserRepository userR})
      : _chatR = chatR,
        _userR = userR,
        super(ChatState()) {
    subscription = _userR.myUsers?.listen(
      (event) async {
        _chatR.resieveMessage(
            event, _userR.myId!, (await _userR.getAllUsers()));
        add(RecieveMessageEvent(users: event));
      },
    );
    on<SentMessageEvent>(sentMessage);
    on<RecieveMessageEvent>(recievMessage);
    on<AddUserEvent>(addUser);
  }
  sentMessage(SentMessageEvent event, Emitter<ChatState> emit) async {
    final message = MessageModel(date: DateTime.now(), author: event.author);
    if (event.text != null) message.text = event.text;
    await _chatR.sentMessage(event.user, event.author, message);
    await _userR.saveMyUser(event.user, event.author);
  }

  recievMessage(RecieveMessageEvent event, Emitter<ChatState> emit) async {
    _chatR.myChats?.entries.map((e) {
      emit.forEach(e.value, onData: (data) {
        final chat = {...state.chats};
        chat[e.key] = data;
        return state.copyWith(chats: chat);
      });
    });
  }

  addUser(AddUserEvent event, Emitter<ChatState> emit) async {
    await _userR.addUser(event.user);
    _userR.getMyUsers();
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
