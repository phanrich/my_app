import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/widgets/task_list.dart';

import '../../bloc/task/task_bloc.dart';
import '../../models/task.dart';

class RecycleBinScreen extends StatefulWidget {
  const RecycleBinScreen({super.key});
  static const id = "recycle_bin_screen";

  @override
  State<RecycleBinScreen> createState() => _RecycleBinScreenState();
}

class _RecycleBinScreenState extends State<RecycleBinScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        List<Task> allTaskRemove = state.removeTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Recycle Bin"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context
                .read<TaskBloc>()
                .add(RemoveAllTaskEvent(removeAll: allTaskRemove)),
            backgroundColor: Colors.red,
            child: const Icon(Icons.remove_circle),
          ),
          body: Column(
            children: [
              // Text("${state.removeTasks.length} Tasks"),
              Expanded(child: TaskList(allTask: allTaskRemove))
            ],
          ),
        );
      },
    );
  }
}
