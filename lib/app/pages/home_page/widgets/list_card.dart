import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/app/pages/home_page/bloc/list_bloc.dart';
import 'package:task_app/app/theme/box_decoration.dart';
import 'package:task_app/domain/list/list_task.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.list,
    required ListBloc listBloc,
  }) : _listBloc = listBloc;

  final ListTask list;
  final ListBloc _listBloc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/home/:title', extra: list.name),
      child: Container(
        decoration: boxDecor,
        height: 91,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Список',
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      _listBloc.add(RemoveList(name: list.name));
                    },
                    icon: const Icon(Icons.delete),
                  )
                ],
              ),
              Text(list.name),
            ],
          ),
        ),
      ),
    );
  }
}
