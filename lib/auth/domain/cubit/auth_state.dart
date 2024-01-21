// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

class AuthState {
  final String name;
  AuthState({
    this.name = 'unknown',
  });

  AuthState copyWith({
    String? name,
  }) {
    return AuthState(
      name: name ?? this.name,
    );
  }
}
