import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:messanger/auth/domain/cubit/auth_cubit.dart';
import 'package:messanger/message/domain/model/message_model.dart';
import 'package:messanger/message/domain/repository/message_repository.dart';

import '../../../auth/domain/model/user_model.dart';

part 'mess_event.dart';
part 'mess_state.dart';

class MessBloc extends Bloc<MessEvent, MessState> {
  final MessageRepository repo;
  final AuthCubit auth;
  MessBloc({required this.repo, required this.auth})
      : super(const MessState()) {
    on<GetChatEvent>(getChats);
    on<SendMessageEvent>(sendMessage);
    on<ChangeCurrentEvent>(changeCurrent);
    on<GetUsersEvent>(getUsers);
    on<SendAudioEvent>(sendAudio);

    auth.stream.listen((event) {
      if (event.user.name != 'unknown') {
        add(GetChatEvent(collection: event.user.id));
      }
    });
  }
  getChats(GetChatEvent event, Emitter<MessState> emit) async {
    final Map<String, ChatModel> chats = {};
    await emit.forEach(repo.allMessages(event.collection), onData: (data) {
      data.docs.map((e) {
        final messages = ChatModel.fromMap(e.data());
        chats[e.id] = messages;
      }).toList();
      return state.copyWith(chats: chats);
    });
  }

  getUsers(GetUsersEvent event, Emitter<MessState> emit) async {
    await emit.forEach(repo.allUsers(), onData: (data) {
      final users = data.docs.map((e) => UserModel.fromMap(e.data())).toList();
      return state.copyWith(users: users);
    });
  }

  sendMessage(SendMessageEvent event, Emitter<MessState> emit) async {
    if (repo is! FirebaseMessage) return;
    final message = MessageModel(
        message: event.mess,
        date: DateTime.now(),
        name: (repo as FirebaseMessage).me.name);

    final map = [...state.curList.messages, message];
    final chat = ChatModel(messages: map);
    await repo.sentMessage(
        user: state.current, mes: chat, me: auth.state.user.id);
  }

  changeCurrent(ChangeCurrentEvent event, Emitter<MessState> emit) async {
    emit(state.copyWith(current: event.current));
  }

  sendAudio(SendAudioEvent event, Emitter<MessState> emit) async {
    await (repo as FirebaseMessage)
        .sendAudio(event.file, state.current, state.curList, auth.state.user);
  }
}
