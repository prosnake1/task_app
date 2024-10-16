import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:task_app/app/extensions/custom_padding.dart';
import 'package:task_app/app/pages/home_page/bloc/list_bloc.dart';
import 'package:task_app/app/pages/home_page/widgets/widgets.dart';
import 'package:task_app/app/pages/login_page/bloc/login_bloc.dart';
import 'package:task_app/domain/repositories/list/models/list_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _listBloc = GetIt.I.get<ListBloc>();
  final _logBloc = GetIt.I.get<LoginBloc>();
  String? dropdownVal;
  @override
  void initState() {
    _listBloc.add(LoadList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: const Color.fromRGBO(215, 216, 217, 1),
            height: 1.6,
            width: 380,
          ),
        ),
        title: const Text(
          'Главная страница',
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => _logBloc.add(LogOut()),
            icon: const Icon(Icons.logout)),
        actions: const [
          AddButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
        child: BlocBuilder<ListBloc, ListState>(
          bloc: _listBloc,
          builder: (context, state) {
            if (state is LoadedList) {
              if (state.list.isEmpty) {
                return const Center(
                  child: Text('Здесь пусто'),
                );
              }
              final list = state.list;
              final sorted = state.list;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: SizedBox(),
                        ),
                        DropdownButton<String>(
                          hint: const Text('Сортировка'),
                          onChanged: (value) {
                            setState(() {
                              dropdownVal = value!;
                            });
                          },
                          items: [
                            DropdownMenuItem<String>(
                                value: 'По имени',
                                child: const Text('Сортировка по имени'),
                                onTap: () => sortByName(sorted)),
                          ],
                        ),
                      ],
                    ),
                    5.ph,
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 32,
                      ),
                      itemBuilder: (context, i) {
                        var listObj =
                            (dropdownVal == 'По имени') ? sorted[i] : list[i];
                        return ListCard(list: listObj);
                      },
                    ),
                  ],
                ),
              );
            }
            if (state is ListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  void sortByName(List<ListTask> sorted) {
    sorted.sort((a, b) => a.name
        .toString()
        .toLowerCase()
        .compareTo(b.name.toString().toLowerCase()));
    setState(() {
      sorted;
    });
  }
}
