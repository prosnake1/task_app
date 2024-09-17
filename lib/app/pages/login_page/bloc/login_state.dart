part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class SuccessLogin extends LoginState {}

class FailedLogin extends LoginState {}
