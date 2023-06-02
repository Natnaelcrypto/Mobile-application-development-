import 'package:equatable/equatable.dart';

import '../../task/model/task_model.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskInitial extends TaskState {}

class TaskDataLoaded extends TaskState {
  final Iterable<Task> tasks;

  const TaskDataLoaded([this.tasks = const []]);

  @override
  List<Object> get props => [tasks];
}

class TaskDataLoadingError extends TaskState {
  final Object error;

  const TaskDataLoadingError(this.error);
  @override
  List<Object> get props => [error];
}
