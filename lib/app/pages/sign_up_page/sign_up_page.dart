import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/app/extensions/custom_padding.dart';
import 'package:task_app/app/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late FocusNode _focusNode;
  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('Введите почту'),
                    Padding(
                      padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                      child: Text(
                        'Ваша почта будет использоваться для входа в аккаунт',
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    20.ph,
                    TaskTextField(
                      text: 'Почта',
                      controller: emailController,
                      autoFocus: true,
                      focusNode: _focusNode,
                    ),
                    30.ph,
                    TaskTextField(
                      text: 'Придумайте пароль',
                      controller: passController,
                    ),
                    const Text(
                      '* Пароль должен содержать более 6 символов!',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              TaskTextButton(
                text: 'Создать аккаунт',
                color: const Color.fromRGBO(38, 136, 235, 1),
                onTap: () async {
                  var email = emailController.text.trim();
                  var password = passController.text.trim();
                  if (email.isEmpty || password.length < 7) {
                    return;
                  }
                  if (email.isEmpty || password.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Пожалуйста, заполните все поля');
                    return;
                  }

                  if (password.length < 6) {
                    Fluttertoast.showToast(
                        msg: 'Слабый пароль. Нужно больше 6 символов');

                    return;
                  }

                  try {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    UserCredential userCredential =
                        await auth.createUserWithEmailAndPassword(
                            email: email, password: password);

                    if (userCredential.user != null) {
                      DatabaseReference userRef =
                          FirebaseDatabase.instance.ref().child('users');

                      String uid = userCredential.user!.uid;

                      await userRef.child(uid).set({
                        'email': email,
                        'uid': uid,
                      });

                      Fluttertoast.showToast(msg: 'Успешно');

                      // ignore: use_build_context_synchronously
                      context.go('/');
                    } else {
                      Fluttertoast.showToast(msg: 'Ошибка');
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      Fluttertoast.showToast(msg: 'Слишком слабый пароль!');
                    } else if (e.code == 'email-already-in-use') {
                      Fluttertoast.showToast(msg: 'Аккаунт уже существует');
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: 'Что-то произошло не так');
                  }
                },
              ),
              10.ph,
            ],
          ),
        ),
      ),
    );
  }
}
