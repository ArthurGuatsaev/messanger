part of 'auth_bloc.dart';

class AuthState {
  final UserModel? user;
  final UserStatus status;

  AuthState({this.user})
      : status = user == null ? UserStatus.non : UserStatus.success;
  AuthState copyWith({
    UserModel? user,
    UserStatus? status,
  }) {
    return AuthState(user: user ?? this.user);
  }

  bool get isSuccess => status == UserStatus.success;
}

enum UserStatus {
  non,
  success,
}
