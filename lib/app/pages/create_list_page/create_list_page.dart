import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/app/extensions/custom_padding.dart';
import 'package:task_app/app/widgets/widgets.dart';

class CreateList extends StatefulWidget {
  const CreateList({super.key});

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать список'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Название', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 40, child: TextField()),
              10.ph,
              650.ph,
              TaskTextButton(
                text: 'Создать',
                color: const Color.fromRGBO(38, 136, 235, 1),
                onTap: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
