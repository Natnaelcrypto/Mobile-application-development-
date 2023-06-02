import 'package:flutter_test/flutter_test.dart';
import 'package:pro/task/model/task_model.dart';
import 'package:pro/task/task_bloc/bloc_export.dart';

void main() {
  group('TaskState', () {
    test('TaskLoading state should return correct props', () {
      final state = TaskLoading();

      expect(state.props, []);
    });

    test('TaskDataLoaded state should return correct props', () {
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

      final state = TaskDataLoaded(tasks);

      expect(state.props, [tasks]);
    });

    test('TaskDataLoadingError state should return correct props', () {
      final error = 'An error occurred';

      final state = TaskDataLoadingError(error);

      expect(state.props, [error]);
    });
  });
}
