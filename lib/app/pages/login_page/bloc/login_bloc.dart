import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_app/data/services/auth/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._service) : super(LoginInitial()) {
    on<LogIn>(_login);
  }
  final AuthService _service;
  Future<void> _login(LogIn event, Emitter<LoginState> emit) async {
    String email = event.email;
    String password = event.password;
    try {
      emit(LoginInitial());
      bool isSuccess = await _service.logIn(email, password);
      if (isSuccess) {
        emit(SuccessLogin());
      } else {
        emit(FailedLogin());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Проверьте интернет соединение');
      emit(FailedLogin());
    }
  }
}
