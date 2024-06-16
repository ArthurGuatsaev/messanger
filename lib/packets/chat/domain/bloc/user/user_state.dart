part of 'user_bloc.dart';

class UserState {
  final UserModel? user;
  final UserStatus status;

  UserState({this.user})
      : status = user == null ? UserStatus.non : UserStatus.success;
  UserState copyWith({
    UserModel? user,
    UserStatus? status,
  }) {
    return UserState(user: user ?? this.user);
  }
}

enum UserStatus {
  non,
  success,
}
