import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pro/auth/auth_bloc/auth_bloc.dart';
import 'package:pro/auth/auth_bloc/auth_event.dart';
import 'package:pro/auth/auth_bloc/auth_state.dart';
import 'package:pro/auth/auth_model/auth.dart';
import 'package:pro/auth/auth_repository/information_repository.dart';
import 'package:pro/user/model/user_model.dart';

// Create a mock class for the AuthRepository
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      authBloc = AuthBloc(authRepository: mockAuthRepository);
    });

    tearDown(() {
      authBloc.close();
    });

    test('Initial state should be AuthLoading', () {
      expect(authBloc.state, AuthLoading());
    });

    group('AuthLogin event', () {
      test('should emit AuthDataLoaded state on successful login', () async {
        final user = User(
          fristName: 'user',
          lastName: 'l',
          password: '1234',
          userName: 'userl',
          Role: 'admin',
          id: '64771f21b2307bc62cb66886',
          farmName: 'farm',
        );
        final auth = Auth(
          userName: 'userl',
          password: '1234',
          token: 'jwt_token',
        );

        when(mockAuthRepository.login(auth)).thenAnswer((_) async {
          await Future.delayed(Duration(milliseconds: 100));
          return Future?.value(
              user); // Return a resolved Future with the user object
        });

        final expectedStates = [
          AuthLoading(),
          AuthDataLoaded(user),
        ];

        expectLater(authBloc.stream, emitsInOrder(expectedStates));

        authBloc.add(AuthLogin(auth));
      });

      test('should emit AuthDataLoadingError state on login error', () async {
        final auth = Auth(
          userName: 'johndoe',
          password: 'password',
          token: 'jwt_token',
        );

        final error = 'Login failed';

        when(mockAuthRepository.login(auth)).thenThrow(error);

        final expectedStates = [
          AuthLoading(),
          AuthDataLoadingError(error),
        ];

        expectLater(authBloc.stream, emitsInOrder(expectedStates));

        authBloc.add(AuthLogin(auth));
      });
    });

    group('AuthSignup event', () {
      test('should emit AuthDataLoaded state on successful signup', () async {
        final user = User(
          fristName: 'John',
          lastName: 'Doe',
          password: 'password',
          userName: 'johndoe',
          Role: 'user',
          id: '123456789',
          farmName: 'Farm A',
        );

        when(mockAuthRepository.signup(user))
            .thenAnswer((_) => Future.value(user));

        final expectedStates = [
          AuthLoading(),
          AuthDataLoaded(user),
        ];

        expectLater(authBloc.stream, emitsInOrder(expectedStates));

        authBloc.add(AuthSignup(user));
      });

      test('should emit AuthDataLoadingError state on signup error', () async {
        final user = User(
          fristName: 'John',
          lastName: 'Doe',
          password: 'password',
          userName: 'johndoe',
          Role: 'user',
          id: '123456789',
          farmName: 'Farm A',
        );

        final error = 'Signup failed';

        when(mockAuthRepository.signup(user)).thenThrow(error);

        final expectedStates = [
          AuthLoading(),
          AuthDataLoadingError(error),
        ];

        expectLater(authBloc.stream, emitsInOrder(expectedStates));

        authBloc.add(AuthSignup(user));
      });
    });
  });
}
