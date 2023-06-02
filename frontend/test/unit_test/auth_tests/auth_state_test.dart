import 'package:flutter_test/flutter_test.dart';
import 'package:pro/auth/auth_bloc/auth_state.dart';
import 'package:pro/user/model/user_model.dart';

void main() {
  group('AuthState', () {
    test('AuthLoading should be an instance of AuthState', () {
      final authLoading = AuthLoading();
      expect(authLoading, isA<AuthState>());
    });

    test('AuthDataLoaded should be an instance of AuthState', () {
      final user = User(
        fristName: 'John',
        lastName: 'Doe',
        password: 'password',
        userName: 'johndoe',
        Role: 'user',
        id: '123456789',
        farmName: 'Farm A',
      );
      final authDataLoaded = AuthDataLoaded(user);
      expect(authDataLoaded, isA<AuthState>());
    });

    test('AuthDataLoadingError should be an instance of AuthState', () {
      final error = Exception('Error message');
      final authDataLoadingError = AuthDataLoadingError(error);
      expect(authDataLoadingError, isA<AuthState>());
    });

    test('AuthLoading should have empty props', () {
      final authLoading = AuthLoading();
      expect(authLoading.props, isEmpty);
    });

    test('AuthDataLoaded should have the provided user as props', () {
      final user = User(
        fristName: 'John',
        lastName: 'Doe',
        password: 'password',
        userName: 'johndoe',
        Role: 'user',
        id: '123456789',
        farmName: 'Farm A',
      );
      final authDataLoaded = AuthDataLoaded(user);
      expect(authDataLoaded.props, equals([user]));
    });

    test('AuthDataLoadingError should have the provided error as props', () {
      final error = Exception('Error message');
      final authDataLoadingError = AuthDataLoadingError(error);
      expect(authDataLoadingError.props, equals([error]));
    });
  });
}
