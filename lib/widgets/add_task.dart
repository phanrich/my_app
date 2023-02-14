import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/models/task.dart';
import 'package:my_app/utils/ultis.dart';

import '../bloc/task/task_bloc.dart';

class AddTask extends StatelessWidget {
  const AddTask({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final TextEditingController title;
  final TextEditingController subTitle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const Text("Add Task"),
              const SizedBox(
                height: 10,
              ),
              TextField(
                autofocus: true,
                controller: title,
                decoration: const InputDecoration(
                    label: Text("Title"), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                autofocus: true,
                controller: subTitle,
                decoration: const InputDecoration(
                    label: Text("SubTitle"), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancel")),
                  ElevatedButton(
                      onPressed: () {
                        Task task = Task(
                            id: Ultis.getRandomString(10),
                            tilte: title.text,
                            subTitle: subTitle.text);
                        context.read<TaskBloc>().add(AddTaskEvent(task: task));
                        Navigator.of(context).pop();
                      },
                      child: const Text("Add"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
