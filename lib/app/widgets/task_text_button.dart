import 'package:flutter/material.dart';

class TaskTextButton extends StatelessWidget {
  const TaskTextButton(
      {super.key,
      required this.text,
      this.color,
      required this.onTap,
      this.isActivated});
  final String text;
  final Color? color;
  final Function() onTap;
  final bool? isActivated;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: (isActivated == null || isActivated != false) ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: color?.withOpacity(0.4),
        ),
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
