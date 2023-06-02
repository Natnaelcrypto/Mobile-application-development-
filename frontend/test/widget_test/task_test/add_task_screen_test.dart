import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/task/repository/task_repository.dart';
import 'package:pro/task/task_bloc/bloc_export.dart';
import 'package:pro/task/task_data_providers/API/task_data_provider.dart';
import 'package:pro/task/task_data_providers/Local_Storage/Local_Storage.dart';
import 'package:pro/task/view/add_task_screen.dart';

void main() {
  group('AddTaskScreen Widget Test', () {
    testWidgets('Title and Description fields validation',
        (WidgetTester tester) async {
      final taskDataProvider = TaskDataProvider();
      final dbHelper = TaskDbHelper();
      final taskRepository = TaskRepository(taskDataProvider, dbHelper);
      final taskBloc = TaskBloc(taskRepository: taskRepository);
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<TaskBloc>(
            create: (_) => taskBloc,
            child: const Scaffold(
              body: AddTaskScreen(),
            ),
          ),
        ),
      );

      // Find the title TextFormField
      final titleField = find.widgetWithText(TextFormField, 'Title');
      expect(titleField, findsOneWidget);

      // Enter empty text into the title field
      await tester.enterText(titleField, '');

      // Find the description TextFormField
      final descriptionField =
          find.widgetWithText(TextFormField, 'Description');
      expect(descriptionField, findsOneWidget);

      // Enter empty text into the description field
      await tester.enterText(descriptionField, '');

      // Find the Add button
      final addButton = find.widgetWithText(ElevatedButton, 'Add');
      expect(addButton, findsOneWidget);

      // Tap the Add button
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Verify that the validation errors are shown
      expect(find.text('Title is required'), findsOneWidget);
      expect(find.text('Description is required'), findsOneWidget);

      // Enter valid text into the title field
      await tester.enterText(titleField, 'Task Title');

      // Enter valid text into the description field
      await tester.enterText(descriptionField, 'Task Description');

      // Tap the Add button
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Verify that the validation errors are not shown
      expect(find.text('Title is required'), findsNothing);
      expect(find.text('Description is required'), findsNothing);

      // Verify that the TaskCreate event is added to the bloc
      expect(taskBloc.state, emits(isA<TaskDataLoaded>()));
    });

    testWidgets('Back button navigation', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AddTaskScreen(),
          ),
        ),
      );

      // Find the Back button
      final backButton = find.widgetWithText(TextButton, 'Back');
      expect(backButton, findsOneWidget);

      // Tap the Back button
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Verify the navigation to the "/tasklist" route
      expect(GoRouter.of(tester.element(find.byType(AddTaskScreen))).location,
          '/tasklist');
    });
  });
}
