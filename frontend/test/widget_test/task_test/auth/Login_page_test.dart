import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pro/auth/auth_bloc/auth_bloc.dart';
import 'package:pro/auth/auth_bloc/auth_event.dart';
import 'package:pro/auth/auth_bloc/auth_state.dart';
import 'package:pro/auth/auth_data_providers/auth_data_provider.dart';
import 'package:pro/auth/auth_model/auth.dart';
import 'package:pro/auth/auth_repository/information_repository.dart';
import 'package:pro/auth/view/auth/signup.dart';
import 'package:pro/localStroe/store.dart';
import 'package:pro/screens/Home.dart';
import 'package:pro/screens/loading_page.dart';

import 'package:pro/auth/view/auth/login_page.dart';
import 'package:pro/user/model/user_model.dart';


class MockAuthBloc extends Mock implements AuthBloc {}

class MockAuthDataProvider extends Mock implements AuthDataProvider {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('LoginPage', () {
    late MockAuthBloc authBloc;
    late MockAuthDataProvider authDataProvider;
    late MockAuthRepository authRepository;

    setUp(() {
      authBloc = MockAuthBloc();
      authDataProvider = MockAuthDataProvider();
      authRepository = MockAuthRepository();
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
          ],
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Verify that the login page is rendered with the expected form fields and buttons
      expect(find.text('UserName'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text('Don\'t have an account? Sign up'), findsOneWidget);
    });

    testWidgets('triggers login event and navigates to home page on successful login',
        (WidgetTester tester) async {
      final mockUser = Auth(
        userName: 'testuser',
        password: 'testpassword',
        token: '',
      );
      const mockUserId = 'mock_user_id';
      const mockFarmName = 'mock_farm_name';
      const mockUserRole = 'mock_user_role';

      when(authBloc.state).thenReturn(AuthDataLoaded(mockUser as User));
      when(authRepository.dataProvider(mockUser))
          .thenAnswer((_) async => AuthData(
                id: mockUserId,
                farmName: mockFarmName,
                role: mockUserRole,
              ));

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
          ],
          child: MaterialApp(
            home: LoginPage(),
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => const LoadingScreen(),
              settings: settings,
            ),
          ),
        ),
      );

      // Fill in the login form fields
      await tester.enterText(find.byType(TextFormField).first, mockUser.userName);
      await tester.enterText(find.byType(TextFormField).last, mockUser.password);

      // Tap the login button
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      // Verify that the login event is triggered with the correct user data
      verify(authBloc.add(AuthLogin(mockUser))).called(1);

      // Verify that the user preferences are updated with the correct values
      expect(UserPreferences.username, mockUser.userName);
      expect(UserPreferences.role, mockUserRole);
      expect(UserPreferences.userId, mockUserId);
      expect(UserPreferences.farmName, mockFarmName);

      // Verify that the app navigates to the home page
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('shows error message on login failure', (WidgetTester tester) async {
      const errorMessage = 'Invalid credentials';

      when(authBloc.state).thenReturn(const AuthDataLoadingError(errorMessage));

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
          ],
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Fill in the login form fields
      await tester.enterText(find.byType(TextFormField).first, 'testuser');
      await tester.enterText(find.byType(TextFormField).last, 'testpassword');

      // Tap the login button
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      // Verify that the login event is triggered with the correct user data
      verify(authBloc.add(mockUser)).called(1);

      // Verify that the error message is displayed
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('navigates to signup page when "Sign up" is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
          ],
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Tap the "Sign up" text
      await tester.tap(find.text('Don\'t have an account? Sign up'));
      await tester.pumpAndSettle();

      // Verify that the app navigates to the signup page
      expect(find.byType(SignupPage), findsOneWidget);
    });
  });
}

