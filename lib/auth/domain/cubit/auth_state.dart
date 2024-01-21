// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

class AuthState {
  final UserModel user;
  AuthState({
    required this.user,
  });

  AuthState copyWith({
    UserModel? user,
  }) {
    return AuthState(
      user: user ?? this.user,
    );
  }
}
