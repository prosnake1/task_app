import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<AddUser>(_addUser);
  }
  Future<void> _addUser(AddUser event, Emitter<SignUpState> emit) async {
    var password = event.password;
    var email = event.email;
    try {
      emit(SignUpInitial());
      FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('users');

        String uid = userCredential.user!.uid;

        await userRef.child(uid).set({
          'email': email,
          'uid': uid,
        });
        emit(SuccessSignUp());
        Fluttertoast.showToast(msg: 'Успешно');
      } else {
        emit(FailedSignUp());
        Fluttertoast.showToast(msg: 'Ошибка');
      }
    } on FirebaseAuthException catch (e) {
      emit(FailedSignUp());
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Слишком слабый пароль!');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Аккаунт уже существует');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Что-то произошло не так');
    }
  }
}
