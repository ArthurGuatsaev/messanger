part of 'auth_bloc.dart';

class AuthState {
  final UserModel? user;
  final UserStatus status;

  AuthState({this.user, this.status = UserStatus.non});
  AuthState copyWith({
    UserModel? user,
    UserStatus? status,
  }) {
    return AuthState(user: user ?? this.user, status: status ?? this.status);
  }

  bool get isSuccess => status == UserStatus.success;
  bool get isLoading => status == UserStatus.loading;
}

enum UserStatus {
  non,
  success,
  loading,
}
