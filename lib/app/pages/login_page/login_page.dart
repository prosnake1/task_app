import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/app/extensions/custom_padding.dart';
import 'package:task_app/app/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/icon.png'),
                    const Text(
                      'Вход мои Задачи',
                      textAlign: TextAlign.center,
                    ),
                    20.ph,
                    TaskTextField(
                      text: 'Почта',
                      controller: emailController,
                      autoFocus: true,
                      focusNode: _focusNode,
                    ),
                    20.ph,
                    TaskTextField(
                      text: 'Пароль',
                      controller: passController,
                    ),
                    20.ph,
                    TaskTextButton(
                      text: 'Войти',
                      color: const Color.fromRGBO(38, 136, 235, 1),
                      onTap: () async {
                        var email = emailController.text.trim();
                        var password = passController.text.trim();
                        if (email.isEmpty) {
                          Fluttertoast.showToast(msg: 'Введите почту');
                          Vibrate.vibrate();
                          return;
                        }
                        if (password.isEmpty) {
                          Fluttertoast.showToast(msg: 'Введите пароль');
                          Vibrate.vibrate();
                          return;
                        }
                        try {
                          FirebaseAuth auth = FirebaseAuth.instance;

                          UserCredential userCredential =
                              await auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                          if (userCredential.user != null) {
                            Fluttertoast.showToast(
                                msg:
                                    'Вы вошли в аккаунт ${FirebaseAuth.instance.currentUser!.email}');

                            // ignore: use_build_context_synchronously
                            context.go('/');
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            Fluttertoast.showToast(
                                msg: 'пользователь не найден');
                          } else if (e.code == 'wrong-password') {
                            Fluttertoast.showToast(msg: 'неверный пароль');
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    'Неизвестная почта или неправильный пароль');
                          }
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: 'Проверьте интернет соединение');
                        }
                      },
                    ),
                  ],
                ),
              ),
              TaskTextButton(
                text: 'Зарегистрироваться',
                color: const Color.fromRGBO(75, 179, 75, 1),
                onTap: () => context.push('/login/sign-up'),
              ),
              10.ph,
            ],
          ),
        ),
      ),
    );
  }
}
