import 'package:flutter_test/flutter_test.dart';
import 'package:pro/user/model/user_model.dart';
import 'package:pro/user/user_bloc/user_event.dart';

void main() {
  group('UserEvent', () {
    test('UserLoad event should have empty props', () {
      final event = UserLoad();
      expect(event.props, []);
    });

    test('UserCreate event should have user prop', () {
      final user = User(
        fristName: 'John',
        lastName: 'Doe',
        password: 'password',
        userName: 'johndoe',
        Role: 'user',
        id: '1',
        farmName: 'Farm A',
      );

      final event = UserCreate(user);

      expect(event.props, [user]);
    });

    test(
        'UserCreate event toString() should return correct string representation',
        () {
      final user = User(
        fristName: 'John',
        lastName: 'Doe',
        password: 'password',
        userName: 'johndoe',
        Role: 'user',
        id: '1',
        farmName: 'Farm A',
      );

      final event = UserCreate(user);

      expect(event.toString(), 'User Created {User Id: ${user.id}}');
    });

    test('UserUpdate event should have id and user props', () {
      final user = User(
        fristName: 'John',
        lastName: 'Doe',
        password: 'password',
        userName: 'johndoe',
        Role: 'user',
        id: '1',
        farmName: 'Farm A',
      );

      final event = UserUpdate('1', user);

      expect(event.props, ['1', user]);
    });

    test(
        'UserUpdate event toString() should return correct string representation',
        () {
      final user = User(
        fristName: 'John',
        lastName: 'Doe',
        password: 'password',
        userName: 'johndoe',
        Role: 'user',
        id: '1',
        farmName: 'Farm A',
      );

      final event = UserUpdate('1', user);

      expect(event.toString(), 'User Updated {User Id: ${user.id}}');
    });

    test('UserDelete event should have id prop', () {
      final event = UserDelete('1');

      expect(event.props, ['1']);
    });

    test(
        'UserDelete event toString() should return correct string representation',
        () {
      final event = UserDelete('1');

      expect(event.toString(), 'User Deleted {User Id: 1}');
    });
  });
}
