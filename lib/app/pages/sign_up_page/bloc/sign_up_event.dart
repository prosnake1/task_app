part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class AddUser extends SignUpEvent {
  AddUser({required this.email, required this.password});
  final String email;
  final String password;
}
