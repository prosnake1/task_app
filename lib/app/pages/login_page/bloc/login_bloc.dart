import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_app/app/router.dart';
import 'package:task_app/data/services/auth/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._service) : super(LoginInitial()) {
    on<LogIn>(_login);
    on<LogOut>(_logOut);
  }
  final AuthService _service;

  Future<void> _logOut(LogOut event, Emitter<LoginState> emit) async {
    try {
      emit(LoadingLogin());
      _service.logOut();
      router.go('/login');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Проверьте интернет соединение');
      emit(FailedLogin());
    }
  }

  Future<void> _login(LogIn event, Emitter<LoginState> emit) async {
    String email = event.email;
    String password = event.password;
    try {
      emit(LoadingLogin());
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
