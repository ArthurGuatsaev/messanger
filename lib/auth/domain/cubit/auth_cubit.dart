import 'package:bloc/bloc.dart';
import 'package:messanger/auth/domain/user_repository.dart';
import 'package:messanger/navigation/nav_manager.dart';

import '../model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository repo;
  AuthCubit({required this.repo}) : super(AuthState(user: repo.user));

  auth(String name) async {
    if (name.isEmpty) return;
    final user = await repo.setUser(name);
    emit(state.copyWith(user: user));
    MyNavigatorManager.instance.pushHome();
  }
}
