part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {}

class SignUpInitial extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SuccessSignUp extends SignUpState {
  @override
  List<Object?> get props => [];
}

class FailedSignUp extends SignUpState {
  @override
  List<Object?> get props => [];
}
