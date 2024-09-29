part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class SuccessLogin extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoadingLogin extends LoginState {
  @override
  List<Object?> get props => [];
}

class FailedLogin extends LoginState {
  @override
  List<Object?> get props => [];
}
