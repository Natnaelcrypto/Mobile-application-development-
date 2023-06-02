import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pro/auth/auth_repository/information_repository.dart';

import 'package:pro/auth/auth_bloc/auth_bloc.dart';
import 'package:pro/auth/auth_bloc/auth_event.dart';
import 'package:pro/auth/auth_bloc/auth_state.dart';
import 'package:pro/auth/view/auth/signup.dart';
import 'package:pro/user/model/user_model.dart';

class MockAuthBloc extends Mock implements AuthBloc {}
class FakeUser extends Fake implements User{}

void main() {
  group('SignUpPage', () {
    late MockAuthBloc authBloc;
    late FakeUser fakeUser;

    setUp(() {
      authBloc = MockAuthBloc();
      fakeUser = FakeUser();
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>.value(
            value: authBloc,
            child: SignupPage(),
          ),
        ),
      );
      when(authBloc.state).thenReturn(AuthDataLoaded(fakeUser));


      // Verify that the SignUpPage is rendered with the expected form fields
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.byType(TextField).at(0), findsOneWidget);
      expect(find.byType(TextField).at(1), findsOneWidget);
      expect(find.byType(TextField).at(2), findsOneWidget);
      expect(find.byType(TextField).at(3), findsOneWidget);
      expect(find.byType(TextField).at(4), findsOneWidget);
      expect(find.byType(TextField).at(5), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('triggers signup event and shows success page when form is valid', (WidgetTester tester) async {
      when(authBloc.state).thenReturn(AuthDataLoaded(fakeUser));


      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>.value(
            value: authBloc,
            child: SignupPage(),
          ),
        ),
      );

      // Fill in the form fields
      await tester.enterText(find.byType(TextField).at(0), 'John');
      await tester.enterText(find.byType(TextField).at(1), 'Doe');
      await tester.enterText(find.byType(TextField).at(2), 'johndoe');
      await tester.enterText(find.byType(TextField).at(3), 'Farm 1');
      await tester.enterText(find.byType(TextField).at(4), 'password');
      await tester.enterText(find.byType(TextField).at(0), 'password');

      // Tap the signup button
      await tester.tap(find.byType(TextButton));
      await tester.pump();

      // Verify that the signup event is triggered with the correct user data
      verify(authBloc.add(AuthSignup(fakeUser))).called(1);

      // Simulate a successful signup by emitting AuthDataLoaded state
      when(authBloc.state).thenReturn(AuthDataLoaded(fakeUser));


      await tester.pump();

      // Verify that the success page is shown
      expect(find.text('Success'), findsOneWidget);
      expect(find.text('Welcome, John Doe'), findsOneWidget);
      expect(find.text('Farm: Farm 1'), findsOneWidget);
    });

    testWidgets('shows error message when signup fails', (WidgetTester tester) async {
      when(authBloc.state).thenAnswer((_) => AuthLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>.value(
            value: authBloc,
            child: SignupPage(),
          ),
        ),
      );

      // Fill in the form fields
      await tester.enterText(find.byKey(const Key('first_name_field')), 'John');
      await tester.enterText(find.byKey(const Key('last_name_field')), 'Doe');
      await tester.enterText(find.byKey(const Key('username_field')), 'johndoe');
      await tester.enterText(find.byKey(const Key('farm_name_field')), 'Farm 1');
      await tester.enterText(find.byKey(const Key('password_field')), 'password');
      await tester.enterText(find.byKey(const Key('confirm_password_field')), 'password');

      // Tap the signup button
      await tester.tap(find.byType(TextButton));
      await tester.pump();

      // Verify that the signup event is triggered with the correct user data
      verify(authBloc.add(AuthSignup(User(
        farmName: 'Farm 1',
        fristName: 'John',
        password: 'password',
        lastName: 'Doe',
        userName: 'johndoe',
        Role: 'user',
        id: '',
      )))).called(1);

      // Simulate a signup error by emitting AuthDataLoadingError state
      const error = 'Signup failed';
      when(authBloc.state).thenAnswer((_) => const AuthDataLoadingError(error));

      await tester.pump();

      // Verify that the error message is shown
      expect(find.text('Change the Username'), findsOneWidget);
    });

  });
}
