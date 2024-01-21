import 'package:bloc/bloc.dart';
import 'package:messanger/auth/domain/user_repository.dart';
import 'package:messanger/navigation/nav_manager.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository repo;
  AuthCubit({required this.repo}) : super(AuthState());
  auth(String name) async {
    if (name.isEmpty) return;
    await repo.setUser(name);
    emit(state.copyWith(name: name));
    MyNavigatorManager.instance.pushHome();
  }
}
