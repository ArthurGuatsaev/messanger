import 'package:bloc/bloc.dart';
import 'package:messanger/message/domain/model/message_model.dart';
import 'package:messanger/message/domain/repository/message_repository.dart';

part 'mess_event.dart';
part 'mess_state.dart';

class MessBloc extends Bloc<MessEvent, MessState> {
  final MessageRepository repo;
  MessBloc({required this.repo}) : super(const MessState()) {
    on<GetChatEvent>(getChats);
  }
  getChats(GetChatEvent event, Emitter<MessState> emit) async {
    final Map<String, List<MessageModel>> chats = {};
    await emit.forEach(repo.allMessages(), onData: (data) {
      data.docs.map((e) {
        if (chats[e.id] != null) {
          chats[e.id] = chats[e.id]!..add(MessageModel.fromMap(e.data()));
        } else {
          chats[e.id] = [MessageModel.fromMap(e.data())];
        }
      }).toList();
      return state.copyWith(chats: chats);
    });
  }

  sendMessage(SendMessageEvent event, Emitter<MessState> emit) async {
    await repo.sentMessage(user: event.me, me: event.me, mes: event.mess);
  }

  changeCurrent(ChangeCurrentEvent event, Emitter<MessState> emit) async {
    emit(state.copyWith(current: event.current));
  }
}
