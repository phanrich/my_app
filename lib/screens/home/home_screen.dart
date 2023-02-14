import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/task/task_bloc.dart';
import '../../models/task.dart';
import '../../widgets/add_task.dart';
import '../../widgets/task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const id = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  void _addTask(BuildContext context) {
    showBottomSheet(
        context: context,
        builder: (context) => AddTask(title: title, subTitle: subTitle));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          body: TaskList(allTask: state.allTask),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
