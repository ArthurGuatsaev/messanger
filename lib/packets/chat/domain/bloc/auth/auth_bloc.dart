import 'package:bloc/bloc.dart';
import 'package:messanger/packets/chat/domain/models/user_model.dart';
import 'package:messanger/packets/chat/domain/repositories/base_auth_repository.dart';
import 'package:messanger/packets/chat/domain/repositories/base_user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BaseAuthRepository _authR;
  final BaseUserRepository _userR;
  AuthBloc(
      {required BaseAuthRepository authR, required BaseUserRepository userR})
      : _authR = authR,
        _userR = userR,
        super(AuthState(user: authR.user)) {
    on<SetUserEvent>(setUser);
  }
  setUser(SetUserEvent event, Emitter<AuthState> emit) async {
    await _authR.setUser(event.name, event.lastName);
    await _authR.getUser();
    if (_authR.user != null) await _userR.addUser(_authR.user!);
    emit(state.copyWith(user: _authR.user));
  }
}
