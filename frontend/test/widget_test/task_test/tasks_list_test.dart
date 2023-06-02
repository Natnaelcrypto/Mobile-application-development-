import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: unused_import
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';

import 'package:pro/task/model/task_model.dart';
import 'package:pro/task/task_bloc/bloc_export.dart';
import 'package:pro/task/task_data_providers/API/task_data_provider.dart';
import 'package:pro/task/task_data_providers/Local_Storage/Local_Storage.dart';
import 'package:pro/task/view/tasks_list.dart';
import 'package:pro/task/repository/task_repository.dart';

void main() {
  group('TasksList Widget', () {
    late TaskBloc taskBloc;
    late Widget testWidget;
    late List<Task> tasks;
    late TaskRepository taskRepository;

    setUp(() {
      final taskDataProvider = TaskDataProvider();
      final taskDbHelper = TaskDbHelper();
      taskRepository = TaskRepository(taskDataProvider, taskDbHelper);
      taskBloc = TaskBloc(taskRepository: taskRepository);
      testWidget = MaterialApp(
        home: BlocProvider<TaskBloc>.value(
          value: taskBloc,
          child: TasksList(status: true),
        ),
      );
      tasks = [
        Task(
          assgined_to: 'John',
          farmname: 'Farm A',
          title: 'Task 1',
          detail: 'Task 1 Details',
          status: true,
          id: '1',
          date_created: '2023-06-01',
        ),
        Task(
          assgined_to: 'Mary',
          farmname: 'Farm B',
          title: 'Task 2',
          detail: 'Task 2 Details',
          status: true,
          id: '2',
          date_created: '2023-06-02',
        ),
      ];
    });

    tearDown(() {
      taskBloc.close();
    });

    testWidgets('should display No Task text when tasks list is empty',
        (WidgetTester tester) async {
      when(taskRepository.fetchAll()).thenAnswer((_) async => []);
      await tester.pumpWidget(testWidget);
      expect(find.text('No Task'), findsOneWidget);
    });

    testWidgets('should display tasks when tasks list is not empty',
        (WidgetTester tester) async {
      when(taskRepository.fetchAll()).thenAnswer((_) async => tasks);
      await tester.pumpWidget(testWidget);
      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);
    });

    // Rest of the test cases...
  });
}
