import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pro/task/view/completed_tasks_screen.dart';
import 'package:pro/task/view/tasks_list.dart';

void main() {
  testWidgets('CompletedTasksScreen should display tasks list',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CompletedTasksScreen(),
      ),
    );

    // Verify that the "Tasks" chip is displayed
    expect(find.text('Tasks'), findsOneWidget);

    // Verify that the TasksList widget is displayed
    expect(find.byType(TasksList), findsOneWidget);
  });
}
