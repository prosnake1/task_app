import 'package:flutter/material.dart';

class TaskTextField extends StatelessWidget {
  const TaskTextField(
      {super.key, required this.text, this.autoFocus, this.focusNode});
  final String text;
  final bool? autoFocus;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 44,
      child: TextField(
        autofocus: (autoFocus == null) ? false : true,
        decoration: InputDecoration(hintText: text),
        cursorColor: const Color.fromRGBO(38, 136, 235, 1),
        focusNode: focusNode,
      ),
    );
  }
}
