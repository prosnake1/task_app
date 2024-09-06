import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/app/pages/home_page/bloc/list_bloc.dart';
import 'package:task_app/app/pages/home_page/widgets/widgets.dart';
import 'package:task_app/app/theme/box_decoration.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _listBloc = GetIt.I.get<ListBloc>();
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
            onPressed: () {
              FirebaseAuth.instance.signOut();
              context.go('/login');
            },
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
              return ListView.separated(
                itemCount: state.filmsList.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 32,
                ),
                itemBuilder: (context, i) {
                  final list = state.filmsList[i];
                  return InkWell(
                    onTap: () => context.push('/list', extra: list.name),
                    child: Container(
                      decoration: boxDecor,
                      height: 91,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Список',
                              style: Theme.of(context).textTheme.labelMedium,
                              textAlign: TextAlign.left,
                            ),
                            Text(list.name),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
}
