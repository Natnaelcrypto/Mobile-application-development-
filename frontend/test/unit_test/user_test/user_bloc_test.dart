import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pro/user/model/user_model.dart';
import 'package:pro/user/user_bloc/user_bloc.dart';
import 'package:pro/user/user_bloc/user_event.dart';
import 'package:pro/user/user_bloc/user_state.dart';
import 'package:pro/user/user_repository/user_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('UserBloc', () {
    late UserBloc userBloc;
    late MockUserRepository mockUserRepository;

    setUp(() {
      mockUserRepository = MockUserRepository();
      userBloc = UserBloc(userRepository: mockUserRepository);
    });

    tearDown(() {
      userBloc.close();
    });

    test('initial state should be UserLoading', () {
      expect(userBloc.state, UserLoading());
    });

    test('emits UserLoading and UserDataLoaded when UserLoad event is added',
        () {
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

      when(mockUserRepository.fetchAll())
          .thenAnswer((_) => Future.value(users));

      expectLater(
        userBloc,
        emitsInOrder([
          UserLoading(),
          UserDataLoaded(users),
        ]),
      );

      userBloc.add(UserLoad());
    });

    test('emits UserLoading and UserDataLoaded when UserCreate event is added',
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

      when(mockUserRepository.create(user)).thenAnswer((_) => Future.value());

      when(mockUserRepository.fetchAll())
          .thenAnswer((_) => Future.value([user]));

      expectLater(
        userBloc,
        emitsInOrder([
          UserLoading(),
          UserDataLoaded([user]),
        ]),
      );

      userBloc.add(UserCreate(user));
    });

    test('emits UserLoading and UserDataLoaded when UserUpdate event is added',
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

      when(mockUserRepository.update(user.id, user))
          .thenAnswer((_) => Future.value());

      when(mockUserRepository.fetchAll())
          .thenAnswer((_) => Future.value([user]));

      expectLater(
        userBloc,
        emitsInOrder([
          UserLoading(),
          UserDataLoaded([user]),
        ]),
      );

      userBloc.add(UserUpdate(user.id, user));
    });

    test('emits UserLoading and UserDataLoaded when UserDelete event is added',
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

      when(mockUserRepository.delete(user.id))
          .thenAnswer((_) => Future.value());

      when(mockUserRepository.fetchAll()).thenAnswer((_) => Future.value([]));

      expectLater(
        userBloc,
        emitsInOrder([
          UserLoading(),
          UserDataLoaded([]),
        ]),
      );

      userBloc.add(UserDelete(user.id));
    });
  });
}
