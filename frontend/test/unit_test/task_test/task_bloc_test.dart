import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pro/task/model/task_model.dart';
import 'package:pro/task/repository/task_repository.dart';
import 'package:pro/task/task_bloc/task_bloc.dart';
import 'package:pro/task/task_bloc/task_event.dart';
import 'package:pro/task/task_bloc/task_state.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockRepository;
  late TaskBloc taskBloc;

  setUp(() {
    mockRepository = MockTaskRepository();
    taskBloc = TaskBloc(taskRepository: mockRepository);
  });

  tearDown(() {
    taskBloc.close();
  });

  group('TaskBloc', () {
    final tasks = [
      Task(
        title: 'Task 1',
        detail: 'Task 1 detail',
        status: false,
        id: '1',
        due_date: '2023-06-01',
        date_created: '2023-05-31',
        farmname: 'Farm A',
        assgined_to: 'John Doe',
      ),
      Task(
        title: 'Task 2',
        detail: 'Task 2 detail',
        status: true,
        id: '2',
        due_date: '2023-06-02',
        date_created: '2023-05-30',
        farmname: 'Farm B',
        assgined_to: 'Jane Smith',
      ),
    ];

    test('initial state should be TaskLoading', () {
      expect(taskBloc.state, TaskLoading());
    });

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskDataLoaded] when TaskLoad event is added',
      build: () {
        when(mockRepository.fetchAll()).thenAnswer((_) => Future.value(tasks));
        return taskBloc;
      },
      act: (bloc) => bloc.add(TaskLoad()),
      expect: () => [TaskLoading(), TaskDataLoaded(tasks)],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskDataLoaded] when TaskCreate event is added',
      build: () {
        when(mockRepository.create(tasks[0])).thenAnswer((_) => Future.value());
        when(mockRepository.fetchAll()).thenAnswer((_) => Future.value(tasks));
        return taskBloc;
      },
      act: (bloc) => bloc.add(TaskCreate(tasks[0])),
      expect: () => [TaskLoading(), TaskDataLoaded(tasks)],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskDataLoaded] when TaskUpdate event is added',
      build: () {
        when(mockRepository.update(tasks[0].id, tasks[0]))
            .thenAnswer((_) => Future.value());
        when(mockRepository.fetchAll()).thenAnswer((_) => Future.value(tasks));
        return taskBloc;
      },
      act: (bloc) => bloc.add(TaskUpdate(tasks[0].id, tasks[0])),
      expect: () => [TaskLoading(), TaskDataLoaded(tasks)],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskLoading, TaskDataLoaded] when TaskDelete event is added',
      build: () {
        when(mockRepository.delete(tasks[0].id))
            .thenAnswer((_) => Future.value());
        when(mockRepository.fetchAll()).thenAnswer((_) => Future.value(tasks));
        return taskBloc;
      },
      act: (bloc) => bloc.add(TaskDelete(tasks[0].id)),
      expect: () => [TaskLoading(), TaskDataLoaded(tasks)],
    );
  });
}
