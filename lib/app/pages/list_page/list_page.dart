import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/app/theme/box_decoration.dart';
import 'package:task_app/app/widgets/widgets.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задача'),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/list/create-task');
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
        child: ListView.separated(
          itemCount: 2,
          separatorBuilder: (context, index) => const Divider(
            height: 32,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              child: Container(
                decoration: boxDecor,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 1, bottom: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Задача',
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.left,
                      ),
                      const Text('Название задачи'),
                      Text(
                        'Описание',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Row(
                        children: [
                          Text(
                            'Напоминание в 00:00',
                            style: Theme.of(context).textTheme.labelMedium,
                            textAlign: TextAlign.left,
                          ),
                          const MySwitch()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
