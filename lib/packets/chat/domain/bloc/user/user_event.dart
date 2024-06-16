part of 'user_bloc.dart';

sealed class UserEvent {}

class SetUserEvent extends UserEvent {
  final String name;
  final String lastName;

  SetUserEvent({required this.name, required this.lastName});
}
