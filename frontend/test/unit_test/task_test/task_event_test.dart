import 'package:flutter_test/flutter_test.dart';
import 'package:pro/task/model/task_model.dart';
import 'package:pro/task/task_bloc/bloc_export.dart';

void main() {
  group('TaskEvent', () {
    test('TaskLoad event should return correct props', () {
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

      final event = TaskLoad(task: tasks);

      expect(event.props, [tasks]);
    });

    test('TaskCreate event should return correct props', () {
      final task = Task(
        title: 'Task 1',
        detail: 'Task 1 detail',
        status: false,
        id: '1',
        due_date: '2023-06-01',
        date_created: '2023-05-31',
        farmname: 'Farm A',
        assgined_to: 'John Doe',
      );

      final event = TaskCreate(task);

      expect(event.props, [task]);
      expect(event.toString(), 'Task Created {Task Id: ${task.title}}');
    });

    test('TaskUpdate event should return correct props', () {
      final id = '1';
      final task = Task(
        title: 'Task 1',
        detail: 'Task 1 detail',
        status: false,
        id: '1',
        due_date: '2023-06-01',
        date_created: '2023-05-31',
        farmname: 'Farm A',
        assgined_to: 'John Doe',
      );

      final event = TaskUpdate(id, task);

      expect(event.props, [id, task]);
      expect(event.toString(), 'Task Updated {Task Id: ${task.title}}');
    });

    test('TaskDelete event should return correct props', () {
      final id = '1';

      final event = TaskDelete(id);

      expect(event.props, [id]);
      expect(event.toString(), 'Task Deleted {Task Id: $id}');
    });
  });
}
