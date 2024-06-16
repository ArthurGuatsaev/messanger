import 'package:bloc/bloc.dart';
import 'package:messanger/packets/chat/domain/models/message_model.dart';
import 'package:messanger/packets/chat/domain/models/user_model.dart';
import 'package:messanger/packets/chat/domain/repositories/base_chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final BaseChatRepository _chatR;
  ChatBloc({required BaseChatRepository chatR})
      : _chatR = chatR,
        super(ChatState()) {
    on<SentMessageEvent>(sentMessage);
  }
  sentMessage(SentMessageEvent event, Emitter<ChatState> emit) async {
    final message = MessageModel(date: DateTime.now(), author: event.author);
    if (event.text != null) message.text = event.text;
    await _chatR.sentMessage(event.user, event.author, message);
  }
}
