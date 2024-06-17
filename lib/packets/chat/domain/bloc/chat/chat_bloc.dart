import 'dart:async';

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
  StreamSubscription? subscription;
  ChatBloc(
      {required BaseChatRepository chatR, required BaseUserRepository userR})
      : _chatR = chatR,
        _userR = userR,
        super(ChatState()) {
    subscription = _userR.myUsers?.listen(
      (event) async {
        _chatR.resieveMessage(event.values.toList(), _userR.me!.id);
        add(RecieveMessageEvent(users: event));
      },
    );
    on<SentMessageEvent>(sentMessage);
    on<RecieveMessageEvent>(recievMessage);
    on<AddUserEvent>(addUser);
    on<SetAllUsers>(getAllUsers);
  }
  sentMessage(SentMessageEvent event, Emitter<ChatState> emit) async {
    final date = DateTime.now();
    final message = MessageModel(
        date: date, author: _userR.me!, id: '${date.millisecondsSinceEpoch}');
    if (event.text != null) message.text = event.text;
    await _chatR.sentMessage(
        UserModel.fromMap(event.user!), _userR.me!, message);
    await _userR.saveChatUser(UserModel.fromMap(event.user!), _userR.me!);
  }

  recievMessage(RecieveMessageEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(chatUsers: event.users));
    for (var stream in _chatR.myChats!.entries) {
      return await emit.forEach(stream.value, onData: (data) {
        final chat = {...state.chats};
        chat[stream.key] = data;
        return state.copyWith(chats: chat);
      });
    }
  }

  addUser(AddUserEvent event, Emitter<ChatState> emit) async {
    await _userR.addUser(event.user);
    _userR.setChatUserStream();
  }

  getAllUsers(SetAllUsers event, Emitter<ChatState> emit) async {
    if (event.empty == true) return emit(state.copyWith(allUsers: {}));
    if (state.allUsers.isNotEmpty) return;
    final users = await _userR.getAllUsers();
    emit(state.copyWith(allUsers: users));
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
