import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/app/pages/home_page/bloc/list_bloc.dart';
import 'package:task_app/app/widgets/widgets.dart';

class CreateList extends StatefulWidget {
  const CreateList({super.key});

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  final _listBloc = GetIt.I.get<ListBloc>();
  final nameController = TextEditingController();
  late FocusNode _focusNode;
  @override
  void initState() {
    _focusNode = FocusNode();
    _listBloc.add(LoadList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать список'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            BlocBuilder<ListBloc, ListState>(
              bloc: _listBloc,
              builder: (context, state) {
                if (state is LoadedList) {
                  return TaskTextButton(
                    text: 'Создать',
                    onTap: () async {
                      if (nameController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'Пожалуйста, заполните поле');
                        return;
                      }
                      _listBloc.add(AddList(name: nameController.text));
                      context.pop();
                    },
                  );
                }
                if (state is ListLoading) {
                  return TaskTextButton(
                    text: 'Загрузка...',
                    isActivated: false,
                    onTap: () {},
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
