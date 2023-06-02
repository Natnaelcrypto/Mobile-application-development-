import 'package:flutter_test/flutter_test.dart';
import 'package:pro/auth/auth_bloc/auth_event.dart';
import 'package:pro/user/model/user_model.dart';
import 'package:pro/auth/auth_model/auth.dart';

void main() {
  group('AuthEvent', () {
    test('AuthLoad should be an instance of AuthEvent', () {
      const authLoad = AuthLoad();
      expect(authLoad, isA<AuthEvent>());
    });

    test('AuthLogin should be an instance of AuthEvent', () {
      final auth = Auth(
        userName: 'johndoe',
        password: 'password',
        token: 'jwt_token',
      );
      final authLogin = AuthLogin(auth);
      expect(authLogin, isA<AuthEvent>());
    });

    test('AuthSignup should be an instance of AuthEvent', () {
      final user = User(
        fristName: 'John',
        lastName: 'Doe',
        password: 'password',
        userName: 'johndoe',
        Role: 'user',
        id: '123456789',
        farmName: 'Farm A',
      );
      final authSignup = AuthSignup(user);
      expect(authSignup, isA<AuthEvent>());
    });

    test('AuthLoad should have empty props', () {
      final authLoad = AuthLoad();
      expect(authLoad.props, isEmpty);
    });

    test('AuthLogin should have the provided auth as props', () {
      final auth = Auth(
        userName: 'johndoe',
        password: 'password',
        token: 'jwt_token',
      );
      final authLogin = AuthLogin(auth);
      expect(authLogin.props, equals([auth]));
    });

    test('AuthSignup should have the provided user as props', () {
      final user = User(
        fristName: 'John',
        lastName: 'Doe',
        password: 'password',
        userName: 'johndoe',
        Role: 'user',
        id: '123456789',
        farmName: 'Farm A',
      );
      final authSignup = AuthSignup(user);
      expect(authSignup.props, equals([user]));
    });

    test('AuthLogin toString should contain auth token', () {
      final auth = Auth(
        userName: 'johndoe',
        password: 'password',
        token: 'jwt_token',
      );
      final authLogin = AuthLogin(auth);
      expect(
        authLogin.toString(),
        contains('Auth Created {Auth Id: jwt_token'),
      );
    });

    test('AuthSignup toString should contain user details', () {
      final user = User(
        fristName: 'John',
        lastName: 'Doe',
        password: 'password',
        userName: 'johndoe',
        Role: 'user',
        id: '123456789',
        farmName: 'Farm A',
      );
      final authSignup = AuthSignup(user);
      expect(
        authSignup.toString(),
        contains('Auth Created {Auth Id: $user'),
      );
    });
  });
}
