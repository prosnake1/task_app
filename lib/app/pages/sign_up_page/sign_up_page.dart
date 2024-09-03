import 'package:flutter/material.dart';
import 'package:task_app/app/extensions/custom_padding.dart';
import 'package:task_app/app/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late FocusNode _focusNode;
  String text = 'Далее';
  bool isActivated = false;
  bool isVisible = false;
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
        body: Column(
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
                    onChanged: (value) {
                      if (value.contains('@') && value.isNotEmpty) {
                        setState(() {
                          isActivated = true;
                        });
                      } else {
                        setState(() {
                          isActivated = false;
                        });
                      }
                    },
                    autoFocus: true,
                    focusNode: _focusNode,
                  ),
                  30.ph,
                  Visibility(
                    visible: isVisible,
                    child: TaskTextField(
                      text: 'Придумайте пароль',
                      controller: passController,
                    ),
                  )
                ],
              ),
            ),
            TaskTextButton(
              text: text,
              color: const Color.fromRGBO(38, 136, 235, 1),
              isActivated: isActivated,
              onTap: () {
                if (isVisible == false) {
                  setState(() {
                    isVisible = true;
                  });
                }
                if (isVisible == true) {
                  setState(() {
                    text = 'Создать аккаунт';
                  });
                }
              },
            ),
            10.ph,
          ],
        ),
      ),
    );
  }
}
