import 'package:flutter/material.dart';
import 'package:task_app/app/extensions/custom_padding.dart';
import 'package:task_app/app/theme/box_decoration.dart';
import 'package:task_app/domain/repositories/task/models/task.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onPressed,
  });

  final Task task;
  final Function() onTap;
  final Function() onPressed;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
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
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  IconButton(
                    onPressed: widget.onPressed,
                    icon: const Icon(Icons.delete),
                  )
                ],
              ),
              Text(
                widget.task.name,
              ),
              Text(
                widget.task.desc,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Row(
                children: [
                  (widget.task.time.isNotEmpty)
                      ? Column(
                          children: [
                            (DateTime.parse(widget.task.time)
                                        .isAfter(DateTime.now()) ==
                                    true)
                                ? Text(
                                    'Напоминание в ${widget.task.time.substring(5, 16)}',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                    textAlign: TextAlign.left,
                                  )
                                : Text(
                                    'Напоминание прошло',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
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
  }
}
