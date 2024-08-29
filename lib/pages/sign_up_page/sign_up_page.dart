import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/pages/login_page/widgets/widgets.dart';
import 'package:task_app/repositories/sizes/custom_padding.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              60.ph,
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
              const SizedBox(
                width: 360,
                height: 44,
                child: TextField(
                  decoration: InputDecoration(hintText: 'Почта'),
                ),
              ),
              540.ph,
              GamaTextButton(
                text: 'Продолжить',
                color: const Color.fromRGBO(38, 136, 235, 1),
                onTap: () => context.push('/'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
