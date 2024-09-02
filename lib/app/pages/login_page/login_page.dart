import 'package:flutter/material.dart';
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
        body: Column(
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
                    autoFocus: true,
                    focusNode: _focusNode,
                  ),
                  20.ph,
                  TaskTextButton(
                    text: 'Войти',
                    color: const Color.fromRGBO(38, 136, 235, 1),
                    onTap: () => context.push('/'),
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
    );
  }
}
