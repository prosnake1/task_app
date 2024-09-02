import 'package:flutter/material.dart';

class TaskTextButton extends StatelessWidget {
  const TaskTextButton(
      {super.key,
      required this.text,
      required this.color,
      required this.onTap});
  final String text;
  final Color color;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(backgroundColor: WidgetStateProperty.all(color)),
        child: SizedBox(
          width: 340,
          height: 24,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'VKSansDisplay', color: Colors.white),
          ),
        ),
      ),
    );
  }
}
