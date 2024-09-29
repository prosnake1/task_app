part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class LogIn extends LoginEvent {
  LogIn({required this.email, required this.password});
  final String email;
  final String password;
  @override
  List<Object?> get props => [email, password];
}

class LogOut extends LoginEvent {
  @override
  List<Object?> get props => [];
}
