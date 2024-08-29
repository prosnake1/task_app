import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/pages/login_page/widgets/widgets.dart';
import 'package:task_app/repositories/sizes/custom_padding.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              250.ph,
              Image.asset('images/icon.png'),
              const Text(
                'Вход мои Задачи',
                textAlign: TextAlign.center,
              ),
              20.ph,
              const SizedBox(
                width: 360,
                height: 44,
                child: TextField(
                  decoration: InputDecoration(hintText: 'Почта'),
                ),
              ),
              20.ph,
              GamaTextButton(
                text: 'Войти',
                color: const Color.fromRGBO(38, 136, 235, 1),
                onTap: () => context.push('/'),
              ),
              300.ph,
              GamaTextButton(
                text: 'Зарегистрироваться',
                color: const Color.fromRGBO(75, 179, 75, 1),
                onTap: () => context.push('/login/sign-up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
