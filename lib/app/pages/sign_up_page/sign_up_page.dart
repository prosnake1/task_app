import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:task_app/app/extensions/custom_padding.dart';
import 'package:task_app/app/pages/sign_up_page/bloc/sign_up_bloc.dart';
import 'package:task_app/app/theme/colors.dart';
import 'package:task_app/app/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpBloc = GetIt.I.get<SignUpBloc>();
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
              BlocListener<SignUpBloc, SignUpState>(
                bloc: _signUpBloc,
                listener: (context, state) {
                  if (state is SuccessSignUp) {
                    GetIt.I.get<Talker>().error('Регистрация завершена');
                  }
                  if (state is FailedSignUp) {
                    GetIt.I.get<Talker>().error('Регистрация не завершена');
                  }
                },
                child: TaskTextButton(
                  text: 'Создать аккаунт',
                  color: ThemeColors.green,
                  onTap: () async {
                    var email = emailController.text.trim();
                    var password = passController.text.trim();
                    if (email.isEmpty || password.length < 7) {
                      Fluttertoast.showToast(
                          msg: 'Пожалуйста, заполните все поля');
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

                    _signUpBloc.add(
                      AddUser(email: email, password: password),
                    );
                    context.go('/login');
                  },
                ),
              ),
              // BlocBuilder<SignUpBloc, SignUpState>(
              //   bloc: _signUpBloc,
              //   builder: (context, state) {
              //     return TaskTextButton(
              //       text: 'Создать аккаунт',
              //       color: ThemeColors.green,
              //       onTap: () async {
              //         var email = emailController.text.trim();
              //         var password = passController.text.trim();
              //         if (email.isEmpty || password.length < 7) {
              //           Fluttertoast.showToast(
              //               msg: 'Пожалуйста, заполните все поля');
              //           return;
              //         }
              //         if (email.isEmpty || password.isEmpty) {
              //           Fluttertoast.showToast(
              //               msg: 'Пожалуйста, заполните все поля');
              //           return;
              //         }

              //         if (password.length < 6) {
              //           Fluttertoast.showToast(
              //               msg: 'Слабый пароль. Нужно больше 6 символов');
              //           return;
              //         }

              //         _signUpBloc.add(
              //           AddUser(email: email, password: password),
              //         );
              //         context.go('/home');
              //       },
              //     );
              //   },
              // ),
              10.ph,
            ],
          ),
        ),
      ),
    );
  }
}
