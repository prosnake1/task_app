import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/app/extensions/custom_padding.dart';
import 'package:task_app/app/pages/tasks_list_page/bloc/tasks_list_bloc.dart';
import 'package:task_app/app/theme/box_decoration.dart';

class ListPage extends StatefulWidget {
  final String title;

  const ListPage({super.key, required this.title});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _tasksListBloc = GetIt.I.get<TasksListBloc>();
  bool switched = false;
  @override
  void initState() {
    _tasksListBloc.add(LoadTasks(name: widget.title));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/home/:title/create-task', extra: widget.title);
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
        child: BlocBuilder<TasksListBloc, TasksListState>(
          bloc: _tasksListBloc,
          builder: (context, state) {
            if (state is LoadedTasksList) {
              return ListView.separated(
                itemCount: state.tasks.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 32,
                ),
                itemBuilder: (context, i) {
                  final task = state.tasks[i];
                  if (task.time.isNotEmpty) {
                    switched = true;
                  } else {
                    switched = false;
                  }
                  return InkWell(
                    onTap: () {
                      context.goNamed(
                        'task',
                        extra: widget.title,
                        pathParameters: {
                          'title': widget.title,
                          'name': task.name,
                        },
                        queryParameters: {
                          'desc': task.desc,
                        },
                      );
                    },
                    child: Container(
                      decoration: boxDecor,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Задача',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    _tasksListBloc.add(
                                      RemoveTask(
                                        name: task.name,
                                        parent: widget.title.toString(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete),
                                )
                              ],
                            ),
                            Text(
                              task.name,
                            ),
                            Text(
                              task.desc,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Row(
                              children: [
                                (task.time.isNotEmpty)
                                    ? Column(
                                        children: [
                                          (DateTime.parse(task.time).isAfter(
                                                      DateTime.now()) ==
                                                  true)
                                              ? Text(
                                                  'Напоминание в ${task.time.substring(5, 16)}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                  textAlign: TextAlign.left,
                                                )
                                              : Text(
                                                  'Напоминание прошло',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                  textAlign: TextAlign.left,
                                                ),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            10.ph,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (state is TasksListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TasksListFailure) {
              return const Center(
                child: Text('Что-то пошло не так...'),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
