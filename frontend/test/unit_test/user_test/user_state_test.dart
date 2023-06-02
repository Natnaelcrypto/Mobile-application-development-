import 'package:flutter_test/flutter_test.dart';
import 'package:pro/user/model/user_model.dart';
import 'package:pro/user/user_bloc/user_state.dart';

void main() {
  group('UserState', () {
    test('UserLoading state should have empty props', () {
      final state = UserLoading();
      expect(state.props, []);
    });

    test('UserDataLoaded state should have users prop', () {
      final users = [
        User(
          fristName: 'John',
          lastName: 'Doe',
          password: 'password',
          userName: 'johndoe',
          Role: 'user',
          id: '1',
          farmName: 'Farm A',
        ),
        User(
          fristName: 'Jane',
          lastName: 'Smith',
          password: 'password',
          userName: 'janesmith',
          Role: 'admin',
          id: '2',
          farmName: 'Farm B',
        ),
      ];

      final state = UserDataLoaded(users);

      expect(state.props, [users]);
    });

    test('UserDataLoadingError state should have error prop', () {
      final error = 'Failed to load users';

      final state = UserDataLoadingError(error);

      expect(state.props, [error]);
    });
  });
}
