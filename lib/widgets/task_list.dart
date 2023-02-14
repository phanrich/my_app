import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/task/task_bloc.dart';

import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> allTask;
  const TaskList({
    Key? key,
    required this.allTask,
  }) : super(key: key);

  void _onRemoveOrDeleted(BuildContext context, Task taskItem) {
    taskItem.isDeleted!
        ? context.read<TaskBloc>().add(DeletedTaskEvent(task: taskItem))
        : context.read<TaskBloc>().add(RemoveTaskEvent(task: taskItem));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Chip(label: Text("My task ${allTask.length.toString()}")),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              Task task = allTask[index];
              return ListTile(
                title: Text(
                  task.tilte,
                  style: TextStyle(
                      decoration:
                          task.isDone! ? TextDecoration.lineThrough : null),
                ),
                subtitle: Text(task.subTitle!),
                onLongPress: () => _onRemoveOrDeleted(context, task),
                trailing: Checkbox(
                  onChanged: task.isDeleted == false
                      ? (value) {
                          context
                              .read<TaskBloc>()
                              .add(UpdateTaskEvent(task: task));
                        }
                      : null,
                  value: task.isDone,
                ),
              );
            },
            itemCount: allTask.length,
          ),
        ),
      ],
    );
  }
}
