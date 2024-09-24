import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Future<bool> logIn(email, password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        Fluttertoast.showToast(
          msg: 'Вы вошли в аккаунт ${FirebaseAuth.instance.currentUser!.email}',
        );
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Слишком слабый пароль!');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Аккаунт уже существует');
      }
      return false;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Что-то произошло не так');
      return false;
    }
  }

  Future<bool> createUser(email, password) async {
    try {
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
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Слишком слабый пароль!');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Аккаунт уже существует');
      }
      return false;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Что-то произошло не так');
      return false;
    }
  }
}
