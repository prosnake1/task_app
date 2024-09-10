import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.push('/home/create-list');
      },
      icon: const Icon(
        Icons.add,
        size: 30,
      ),
    );
  }
}
