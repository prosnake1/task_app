import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/app/extensions/custom_padding.dart';
import 'package:task_app/app/pages/login_page/bloc/login_bloc.dart';
import 'package:task_app/app/theme/colors.dart';
import 'package:task_app/app/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginBloc = GetIt.I.get<LoginBloc>();
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
                    BlocListener<LoginBloc, LoginState>(
                      bloc: _loginBloc,
                      listener: (context, state) {
                        if (state is SuccessLogin) {
                          GetIt.I.get<Talker>().debug('Logged');
                          context.go('/home');
                        }
                        if (state is FailedLogin) {
                          GetIt.I.get<Talker>().debug('Failed Login');
                        }
                      },
                      child: TaskTextButton(
                        text: 'Войти',
                        color: ThemeColors.primary,
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
                          _loginBloc.add(
                            LogIn(email: email, password: password),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              TaskTextButton(
                text: 'Зарегистрироваться',
                color: ThemeColors.green,
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
