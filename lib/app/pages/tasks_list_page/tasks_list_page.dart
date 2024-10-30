import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/app/pages/tasks_list_page/bloc/tasks_list_bloc.dart';
import 'package:task_app/app/pages/tasks_list_page/widgets/widgets.dart';
import 'package:task_app/domain/repositories/task/models/task.dart';

class ListPage extends StatefulWidget {
  final String title;

  const ListPage({super.key, required this.title});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _tasksListBloc = GetIt.I.get<TasksListBloc>();
  DateTime now = DateTime.now();
  @override
  void initState() {
    _tasksListBloc.add(LoadTasks(name: widget.title));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задачи'),
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
              var tasks = state.tasks;
              if (tasks.isEmpty) {
                return const Center(
                  child: Text('Здесь пусто'),
                );
              }
              return SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.tasks.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 32,
                  ),
                  itemBuilder: (context, i) {
                    final tasks = state.tasks;
                    sort(tasks);
                    return TaskCard(
                      task: tasks[i],
                      onTap: () {
                        context.goNamed(
                          'task',
                          extra: widget.title,
                          pathParameters: {
                            'title': widget.title,
                            'name': tasks[i].name,
                          },
                          queryParameters: {
                            'desc': tasks[i].desc,
                          },
                        );
                      },
                      onPressed: () async {
                        _tasksListBloc.add(
                          RemoveTask(
                            id: tasks[i].id,
                            parent: widget.title.toString(),
                          ),
                        );
                      },
                    );
                  },
                ),
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

  void sort(List<Task> tasks) {
    tasks.sort(
      (a, b) => a.name.compareTo(b.name),
    );
    tasks.sort(
      (a, b) {
        if (a.time.isNotEmpty && b.time.isNotEmpty) {
          DateTime aDate = DateTime.parse(a.time);
          DateTime bDate = DateTime.parse(b.time);
          if (aDate.isBefore(now) && bDate.isBefore(now)) {
            return 0;
          } else if (aDate.isBefore(now)) {
            return 1;
          } else if (bDate.isBefore(now)) {
            return -1;
          } else {
            return aDate.compareTo(bDate);
          }
        } else {
          return -a.time.compareTo(b.time);
        }
      },
    );
  }

  // List<Task> sortByTime(List<Task> tasks, LoadedTasksList state) {
  //   tasks.sort(
  //     (a, b) => a.time.compareTo(b.time),
  //   );
  //   setState(() {
  //     tasks = state.tasks;
  //   });
  //   return tasks;
  // }

  // void sortByName(List<Task> tasks) {
  //   tasks.sort(
  //     (a, b) => a.name.toString().toLowerCase().compareTo(
  //           b.name.toString().toLowerCase(),
  //         ),
  //   );
  //   setState(() {
  //     tasks;
  //   });
  // }
}
