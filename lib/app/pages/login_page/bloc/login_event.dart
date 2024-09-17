part of 'login_bloc.dart';

abstract class LoginEvent {}

class LogIn extends LoginEvent {
  LogIn({required this.email, required this.password});
  final String email;
  final String password;
}
