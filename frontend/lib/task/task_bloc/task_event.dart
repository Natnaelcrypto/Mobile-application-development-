import 'package:equatable/equatable.dart';

import '../../task/model/task_model.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class TaskLoad extends TaskEvent {
  final List<Task> task;

  const TaskLoad({this.task = const <Task>[]});

  @override
  List<Object> get props {
    return [task];
  }
}

class TaskCreate extends TaskEvent {
  final Task task;

  const TaskCreate(this.task);

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'Task Created {Task Id: ${task.title}}';
}

class TaskUpdate extends TaskEvent {
  final String id;
  final Task task;

  const TaskUpdate(this.id, this.task);

  @override
  List<Object> get props => [id, task];

  @override
  String toString() => 'Task Updated {Task Id: ${task.title}}';
}

class TaskDelete extends TaskEvent {
  final String id;

  const TaskDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Task Deleted {Task Id: $id}';

  @override
  bool? get stringify => true;
}

class TaskReset extends TaskEvent {
  const TaskReset();

  @override
  List<Object> get props => [];
}
