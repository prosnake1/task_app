import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/app/extensions/custom_padding.dart';
import 'package:task_app/app/pages/tasks_list_page/bloc/tasks_list_bloc.dart';
import 'package:task_app/app/pages/tasks_list_page/widgets/widgets.dart';
import 'package:task_app/app/theme/theme.dart';
import 'package:task_app/data/services/sorts/sorts_repository.dart';
import 'package:task_app/domain/repositories/sorts/models/sorts.dart';
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

  bool containsTime = false;

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
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              enableDrag: true,
                              context: context,
                              builder: (context) {
                                List<Sorts> sorts = getSorts();
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Сортировка'),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) {
                                        return ListTile(
                                          enabled: (containsTime == false &&
                                                  sorts[i].option == 'date')
                                              ? false
                                              : true,
                                          titleTextStyle:
                                              lightTheme.textTheme.labelSmall,
                                          title: Text(sorts[i].name),
                                          onTap: () {
                                            tasks = SortsRepository()
                                                .sort(sorts[i].option, tasks);
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const Divider(),
                                      itemCount: sorts.length,
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: const Row(
                            children: [
                              Text('Сортировка'),
                              Icon(Icons.sort_rounded),
                            ],
                          ),
                        ),
                      ],
                    ),
                    5.ph,
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.tasks.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 32,
                      ),
                      itemBuilder: (context, i) {
                        final tasks = state.tasks;
                        if (tasks[i].time.isNotEmpty) {
                          containsTime = true;
                        }
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
                  ],
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
      (a, b) => a.name.length.compareTo(b.name.length),
    );
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
}

class TaskSortTile extends StatelessWidget {
  const TaskSortTile({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
