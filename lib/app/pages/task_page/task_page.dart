import 'package:flutter/material.dart';
import 'package:task_app/app/router.dart';
import 'package:task_app/app/theme/colors.dart';

class TaskPage extends StatefulWidget {
  final String name;
  final String desc;
  const TaskPage({super.key, required this.name, required this.desc});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        leading: IconButton(
            onPressed: () => router.pop(), icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 200,
              color: ThemeColors.primary,
              width: MediaQuery.sizeOf(context).width,
              child: Center(
                child: Text(
                  widget.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: ThemeColors.background,
                child: Column(
                  children: [
                    const Text('Описание'),
                    Text(widget.desc),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
