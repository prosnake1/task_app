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
  bool isActivated = true;
  late FocusNode _focusNode;
  final _loginBloc = GetIt.I.get<LoginBloc>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is SuccessLogin) {
          GetIt.I.get<Talker>().debug('Вход выполнен');
          context.go('/home');
        }
        if (state is FailedLogin) {
          GetIt.I.get<Talker>().error('Вход не завершена');
          isActivated = true;
          setState(() {});
        }
        if (state is LoadingLogin) {
          isActivated = false;
          setState(() {});
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (MediaQuery.of(context).size.height / 5).ph,
                        Image.asset('images/icon.png'),
                        const Text(
                          'Вход Мои Задачи',
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
                      ],
                    ),
                  ),
                ),
                TaskTextButton(
                  text: 'Войти',
                  color: ThemeColors.primary,
                  isActivated: isActivated,
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
                TaskTextButton(
                  text: 'Зарегистрироваться',
                  color: ThemeColors.green,
                  onTap: () => context.push('/login/sign-up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
