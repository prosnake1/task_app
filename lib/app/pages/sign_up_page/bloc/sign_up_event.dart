part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {}

class AddUser extends SignUpEvent {
  AddUser({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
