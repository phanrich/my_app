part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> allTask;
  final List<Task> removeTasks;
  const TaskState(
      {this.allTask = const <Task>[], this.removeTasks = const <Task>[]});

  @override
  List<Object> get props => [allTask, removeTasks];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'allTask': allTask.map((x) => x.toMap()).toList(),
      'removeTasks': removeTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      allTask: List<Task>.from(map['allTask'].map((x) => Task.fromMap(x))),
      removeTasks:
          List<Task>.from(map['removeTasks'].map((x) => Task.fromMap(x))),
    );
  }
}
