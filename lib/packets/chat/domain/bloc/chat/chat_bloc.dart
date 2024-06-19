import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:messanger/packets/chat/domain/models/message/message_model.dart';
import 'package:messanger/packets/chat/domain/models/user/user_model.dart';
import 'package:messanger/packets/chat/domain/repositories/base_chat_repository.dart';
import 'package:messanger/packets/chat/domain/repositories/base_user_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final BaseChatRepository _chatR;
  final BaseUserRepository _userR;
  StreamSubscription? updateSubscription;
  StreamSubscription? chatSubscription;
  ChatBloc(
      {required BaseChatRepository chatR, required BaseUserRepository userR})
      : _chatR = chatR,
        _userR = userR,
        super(ChatState()) {
    updateSubscription = _chatR.needUpdateStream?.listen(
      (event) async {
        log('$event');
        add(RecieveLastMessageEvent(id: event));
      },
    );
    on<SentMessageEvent>(sentMessage);
    on<RecieveLastMessageEvent>(recievLastMessage);
    on<SetAllUsers>(getAllUsers);
    on<InitUpdateStreamEvent>(initUpdateStream);
    on<RecievChatsEvent>(recievChats);
    add(RecievChatsEvent());
    add(SetAllUsers());
  }
  sentMessage(SentMessageEvent event, Emitter<ChatState> emit) async {
    final date = DateTime.now();
    final id = '${date.millisecondsSinceEpoch}';
    final message = MessageModel(date: date, author: _userR.me!, id: id);
    if (event.text != null) message.text = event.text;
    await _chatR.sentMessage(
        UserModel.fromMap(event.user!), _userR.me!, message);
    await _userR.setUpdateEvent(UserModel.fromMap(event.user!), _userR.me!, id);
  }

  recievLastMessage(
      RecieveLastMessageEvent event, Emitter<ChatState> emit) async {
    final messageId = event.id.split('_').last;
    final userId = event.id.split('_').first;
    final message =
        await _chatR.resieveLastMessage(_userR.me!.id, userId, messageId);
    await _chatR.removeUpdateEvent(_userR.me!, event.id);
    final chat = {...state.chats};
    var messages = <MessageModel>[];
    if (chat[userId] != null) messages = chat[userId]!;
    messages.add(message);
    chat[userId] = messages;
    emit(state.copyWith(chats: chat));
    add(SetAllUsers());
  }

  recievChats(RecievChatsEvent event, Emitter<ChatState> emit) async {
    if (_userR.me == null) return;
    var chat = _chatR.chat;
    chat ??= await _chatR.resieveChat(_userR.me!.id);
    emit(state.copyWith(chats: chat));
  }

  getAllUsers(SetAllUsers event, Emitter<ChatState> emit) async {
    var usr = _userR.allUsers;
    usr ??= await _userR.getAllUsers();
    if (event.refresh == true) usr = await _userR.getAllUsers();
    emit(state.copyWith(allUsers: usr));
  }

  initUpdateStream(InitUpdateStreamEvent event, Emitter<ChatState> emit) async {
    _chatR.initUpdateStream(_userR.me!.id);
    updateSubscription = _chatR.needUpdateStream?.listen(
      (event) async {
        add(RecieveLastMessageEvent(id: event));
      },
    );
  }

  @override
  Future<void> close() {
    updateSubscription?.cancel();
    chatSubscription?.cancel();
    return super.close();
  }
}
