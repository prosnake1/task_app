import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_app/data/services/auth/auth_service.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._service) : super(SignUpInitial()) {
    on<AddUser>(_addUser);
  }
  final AuthService _service;
  Future<void> _addUser(AddUser event, Emitter<SignUpState> emit) async {
    var password = event.password;
    var email = event.email;
    try {
      emit(SignUpInitial());
      bool isSuccess = await _service.createUser(email, password);
      if (isSuccess) {
        emit(SuccessSignUp());
      } else {
        emit(FailedSignUp());
      }
    } catch (e) {
      emit(FailedSignUp());
      Fluttertoast.showToast(msg: 'Что-то произошло не так');
    }
  }
}
