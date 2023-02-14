part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final Task task;

  const AddTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

class DeletedTaskEvent extends TaskEvent {
  final Task task;

  const DeletedTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

class RemoveTaskEvent extends TaskEvent {
  final Task task;

  const RemoveTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

class RemoveAllTaskEvent extends TaskEvent {
  final List<Task> removeAll;

  const RemoveAllTaskEvent({required this.removeAll});
  @override
  List<Object> get props => [removeAll];
}
