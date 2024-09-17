part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SuccessSignUp extends SignUpState {}

class FailedSignUp extends SignUpState {}
