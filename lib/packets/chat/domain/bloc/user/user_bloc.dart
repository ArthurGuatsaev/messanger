import 'package:bloc/bloc.dart';
import 'package:messanger/packets/chat/domain/models/user_model.dart';
import 'package:messanger/packets/chat/domain/repositories/base_user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final BaseUserRepository _userR;
  UserBloc({required BaseUserRepository userR})
      : _userR = userR,
        super(UserState(user: userR.user)) {
    on<SetUserEvent>(setUser);
  }
  setUser(SetUserEvent event, Emitter<UserState> emit) async {
    await _userR.setUser(event.name, event.lastName);
    await _userR.getUser();
    emit(state.copyWith(user: _userR.user));
  }
}
