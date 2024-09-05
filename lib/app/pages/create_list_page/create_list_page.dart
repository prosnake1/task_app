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
  var nameController = TextEditingController();
  late FocusNode _focusNode;
  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать список'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text('Список'),
                  TaskTextField(
                    text: 'Название',
                    controller: nameController,
                    autoFocus: true,
                    focusNode: _focusNode,
                  )
                ],
              ),
            ),
            10.ph,
            TaskTextButton(
              text: 'Создать',
              color: const Color.fromRGBO(38, 136, 235, 1),
              onTap: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
