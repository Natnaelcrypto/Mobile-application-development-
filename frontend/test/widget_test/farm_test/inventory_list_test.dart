import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:go_router/go_router.dart';

import 'package:pro/LocalStroe/Store.dart';
import 'package:pro/screens/Drawer.dart';
import 'package:pro/screens/Error_page.dart';
import 'package:pro/user/model/user_model.dart';

import 'package:pro/farm/farm_bloc/farm_bloc.dart';
import 'package:pro/farm/farm_bloc/farm_event.dart';
import 'package:pro/farm/farm_bloc/farm_state.dart';
import 'package:pro/farm/farm_model/farm_model.dart';
import 'package:pro/farm/view/inventory_list.dart';

// Create a mock FarmBloc for testing
class MockFarmBloc extends Mock implements FarmBloc {}

void main() {
  late FarmBloc mockFarmBloc;

  setUp(() {
    mockFarmBloc = MockFarmBloc();
  });

  testWidgets('InventoryListScreen should display items', (WidgetTester tester) async {
    final User mockUser = User(
      fristName: 'John',
      lastName: 'Doe',
      password: 'password123',
      userName: 'johndoe',
      Role: 'user',
      id: '12345',
      farmName: 'Farm 1',
);
; // Create a mock user
    final List<Farm> mockFarms = [
    Farm(
      id_: '1',
      itemName: 'Item 1',
      quantity: '10',
      userID: '12345',
      farmName: 'Farm 1',
      expirationDate: '2023-01-01',
      dosage: '2 tablets',
      instructions: 'Take with water',
      isfeed: false,
      ismedication: true,
      brand: 'Brand A',
      type: 'Medication',
    ),
    Farm(
      id_: '2',
      itemName: 'Item 2',
      quantity: '5',
      userID: '12345',
      farmName: 'Farm 1',
      expirationDate: '2023-02-01',
      dosage: '1 tablet',
      instructions: 'Take before bedtime',
      isfeed: true,
      ismedication: false,
      brand: 'Brand B',
      type: 'Feed',
    ),
  ];

    // Define the state of FarmBloc to be FarmDataLoaded with mockFarms
    when(mockFarmBloc.state).thenReturn(FarmDataLoaded(mockFarms));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FarmBloc>.value(
          value: mockFarmBloc,
          child: InventoryListScreen(user: mockUser),
        ),
      ),
    );

    // Verify that the Inventory List screen is displayed
    expect(find.text('Inventory List'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing); // Loading indicator should not be displayed

    // Verify the item list
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
    expect(find.text('Quantity: 10'), findsOneWidget);
    expect(find.text('Quantity: 5'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);

    // Verify that the add item button is not visible for non-user role
    expect(find.byIcon(Icons.add), findsNothing);

    // Verify that the delete button works
    await tester.tap(find.byIcon(Icons.delete).first);
    verify(mockFarmBloc.add(FarmDelete(mockFarms.first.id_))).called(1);
  });

  testWidgets('InventoryListScreen should display loading indicator', (WidgetTester tester) async {
    final User mockUser = User(
      fristName: 'John',
      lastName: 'Doe',
      password: 'password123',
      userName: 'johndoe',
      Role: 'user',
      id: '12345',
      farmName: 'Farm 1',
);

    // Define the state of FarmBloc to be FarmLoading
    when(mockFarmBloc.state).thenReturn(FarmLoading());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FarmBloc>.value(
          value: mockFarmBloc,
          child: InventoryListScreen(user: mockUser),
        ),
      ),
    );

    // Verify that the loading indicator is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('InventoryListScreen should display error message', (WidgetTester tester) async {
    final User mockUser = User(
      fristName: 'John',
      lastName: 'Doe',
      password: 'password123',
      userName: 'johndoe',
      Role: 'user',
      id: '12345',
      farmName: 'Farm 1',
);
    const String errorMessage = 'Error loading farms';

    // Define the state of FarmBloc to be FarmDataLoadingError with an error message
    when(mockFarmBloc.state).thenReturn(const FarmDataLoadingError(errorMessage));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FarmBloc>.value(
          value: mockFarmBloc,
          child: InventoryListScreen(user: mockUser),
        ),
      ),
    );

    // Verify that the error message is displayed
    expect(find.text(errorMessage), findsOneWidget);
  });

}
