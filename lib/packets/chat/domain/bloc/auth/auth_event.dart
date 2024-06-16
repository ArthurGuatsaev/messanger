part of 'auth_bloc.dart';

sealed class AuthEvent {}

class SetUserEvent extends AuthEvent {
  final String name;
  final String lastName;

  SetUserEvent({required this.name, required this.lastName});
}
