import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LogIn>(_login);
  }
  Future<void> _login(LogIn event, Emitter<LoginState> emit) async {
    String email = event.email;
    String password = event.password;
    try {
      emit(LoginInitial());
      FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        emit(SuccessLogin());
        Fluttertoast.showToast(
            msg:
                'Вы вошли в аккаунт ${FirebaseAuth.instance.currentUser!.email}');
      }
    } on FirebaseAuthException catch (e) {
      emit(FailedLogin());
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'пользователь не найден');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'неверный пароль');
      } else {
        Fluttertoast.showToast(
            msg: 'Неизвестная почта или неправильный пароль');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Проверьте интернет соединение');
    }
  }
}
