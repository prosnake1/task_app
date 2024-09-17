import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/app/extensions/custom_padding.dart';
import 'package:task_app/app/pages/tasks_list_page/bloc/tasks_list_bloc.dart';
import 'package:task_app/app/theme/colors.dart';
import 'package:task_app/app/widgets/widgets.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key, required this.listName});
  final String listName;

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _tasksBloc = GetIt.I.get<TasksListBloc>();
  DateTime scheduleTime = DateTime.now();
  TextEditingController timeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создать задачу в списке ${widget.listName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text('Название', style: TextStyle(fontSize: 18)),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: nameController,
                      ),
                    ),
                    10.ph,
                    const Text('Описание', style: TextStyle(fontSize: 18)),
                    10.ph,
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: descController,
                      ),
                    ),
                    10.ph,
                    Row(
                      children: [
                        const Text(
                          'Напоминание',
                          style: TextStyle(fontSize: 18),
                        ),
                        Switch(
                          activeColor: ThemeColors.primary,
                          value: switchValue,
                          onChanged: (value) {
                            setState(() {
                              switchValue = value;
                            });
                          },
                        )
                      ],
                    ),
                    2.ph,
                    Visibility(
                      visible: switchValue,
                      child: Column(
                        children: [
                          const Text('Установить время',
                              style: TextStyle(fontSize: 18)),
                          SizedBox(
                            height: 40,
                            child: TextFormField(
                              controller: timeController,
                              decoration: const InputDecoration(
                                hintText: '_ _._ _._ _ _ _',
                                suffixIcon: Icon(Icons.access_time),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DatePicker.showDateTimePicker(
                                  context,
                                  showTitleActions: true,
                                  onChanged: (date) => scheduleTime = date,
                                  onConfirm: (date) {
                                    timeController.text = date.toString();
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<TasksListBloc, TasksListState>(
              bloc: _tasksBloc,
              builder: (context, state) {
                if (state is LoadedTasksList) {
                  return TaskTextButton(
                    text: 'Создать',
                    onTap: () async {
                      _tasksBloc.add(
                        AddTask(
                          parent: widget.listName,
                          name: nameController.text.toString(),
                          desc: descController.text.toString(),
                          time: timeController.text.toString(),
                        ),
                      );
                      context.pop();
                    },
                  );
                }
                if (state is TasksListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
