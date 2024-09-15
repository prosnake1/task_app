import 'package:flutter/material.dart';

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
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 200,
              color: Color.fromRGBO(38, 136, 235, 1),
              width: MediaQuery.sizeOf(context).width,
              child: Center(
                  child: Text(
                widget.name,
                style: TextStyle(color: Colors.white),
              )),
            ),
            Expanded(
              child: Container(
                color: const Color.fromRGBO(235, 237, 240, 1),
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
