import 'package:flutter/material.dart';

class Issue extends StatelessWidget {
  const Issue({super.key, required this.text, required this.isVisible});
  final String text;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.red,
        ),
      ),
    );
  }
}
