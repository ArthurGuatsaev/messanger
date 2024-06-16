import 'package:bloc/bloc.dart';
import 'package:messanger/packets/chat/domain/models/user_model.dart';
import 'package:messanger/packets/chat/domain/repositories/base_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BaseAuthRepository _userR;
  AuthBloc({required BaseAuthRepository userR})
      : _userR = userR,
        super(AuthState(user: userR.user)) {
    on<SetUserEvent>(setUser);
  }
  setUser(SetUserEvent event, Emitter<AuthState> emit) async {
    await _userR.setUser(event.name, event.lastName);
    await _userR.getUser();
    emit(state.copyWith(user: _userR.user));
  }
}