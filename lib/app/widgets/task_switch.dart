import 'package:flutter/material.dart';

class MySwitch extends StatefulWidget {
  const MySwitch({
    super.key,
  });
  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: light,
      activeColor: const Color.fromRGBO(38, 136, 235, 1),
      onChanged: (bool value) {
        setState(() {
          light = value;
        });
      },
    );
  }
}
