import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc({required this.taskRepository}) : super(TaskLoading()) {
    on<TaskLoad>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await taskRepository.fetchAll();
        emit(TaskDataLoaded(tasks));
      } catch (error) {
        emit(TaskDataLoadingError(error));
      }
    });

    on<TaskCreate>((event, emit) async {
      try {
        await taskRepository.create(event.task);
        final tasks = await taskRepository.fetchAll();
        emit(TaskDataLoaded(tasks));
      } catch (error) {
        emit(TaskDataLoadingError(error));
      }
    });

    on<TaskUpdate>((event, emit) async {
      try {
        print(event.id);
        print("from udate");
        await taskRepository.update(event.id, event.task);
        final tasks = await taskRepository.fetchAll();
        emit(TaskDataLoaded(tasks));
      } catch (error) {
        emit(TaskDataLoadingError(error));
      }
    });

    on<TaskDelete>((event, emit) async {
      try {
        await taskRepository.delete(event.id);
        final tasks = await taskRepository.fetchAll();
        emit(TaskDataLoaded(tasks));
      } catch (error) {
        emit(TaskDataLoadingError(error));
      }
    });

    on<TaskReset>(
      (event, emit) {
        emit(TaskInitial());
      },
    );
  }
}
