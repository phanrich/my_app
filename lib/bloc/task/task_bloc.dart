import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTaskEvent>(_onAddTaskEvent);
    on<UpdateTaskEvent>(_onUpdateTaskEvent);
    on<DeletedTaskEvent>(_onDeletedTaskEvent);
    on<RemoveTaskEvent>(_onRemoveTaskEvent);
    on<RemoveAllTaskEvent>(_onRemoveAllTaskEvent);
  }

  FutureOr<void> _onAddTaskEvent(AddTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;

    emit(
      TaskState(
        allTask: List.from(state.allTask)..add(event.task),
        removeTasks: state.removeTasks,
      ),
    );
  }

  FutureOr<void> _onUpdateTaskEvent(
      UpdateTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTask.indexOf(task);
    List<Task> allTask = List.from(state.allTask)..remove(task);

    task.isDone == false
        ? allTask.insert(index, task.copyWith(isDone: true))
        : allTask.insert(index, task.copyWith(isDone: false));

    emit(TaskState(allTask: allTask, removeTasks: state.removeTasks));
  }

  FutureOr<void> _onDeletedTaskEvent(
      DeletedTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;

    emit(
      TaskState(
        allTask: state.allTask,
        removeTasks: List.from(state.removeTasks)..remove(event.task),
      ),
    );
  }

  void _onRemoveTaskEvent(RemoveTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
          allTask: List.from(state.allTask)..remove(event.task),
          removeTasks: List.from(state.removeTasks)
            ..add(event.task.copyWith(isDeleted: true))),
    );
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }

  FutureOr<void> _onRemoveAllTaskEvent(
      RemoveAllTaskEvent event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
          allTask: state.allTask,
          removeTasks: List.from(state.removeTasks)..clear()),
    );
  }
}
