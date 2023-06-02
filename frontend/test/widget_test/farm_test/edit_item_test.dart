import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pro/farm/farm_bloc/farm_event.dart';
import 'package:pro/farm/farm_bloc/farm_state.dart';

import 'package:pro/farm/view/edit_item.dart';
import 'package:pro/farm/farm_bloc/farm_bloc.dart';
import 'package:pro/farm/farm_model/farm_model.dart';

class MockFarmBloc extends Mock implements FarmBloc {}

void main() {
  late FarmBloc farmBloc;

  setUp(() {
    farmBloc = MockFarmBloc();
  });

  tearDown(() {
    farmBloc.close();
  });

  testWidgets('EditItemScreen displays item details correctly', (WidgetTester tester) async {
    final mockItem = Farm(
      itemName: 'Item 1',
      quantity: '10',
      expirationDate: '2023-06-01',
      dosage: '2 pills',
      instructions: 'Take with water',
      userID: 'user123',
      farmName: 'Farm 1',
      id_: 'item123',
      isfeed: false,
      ismedication: true,
      brand: '',
      type: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FarmBloc>.value(
          value: farmBloc,
          child: EditItemScreen(item: mockItem),
        ),
      ),
    );

    // Verify that the item details are displayed correctly
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    expect(find.text('2023-06-01'), findsOneWidget);
    expect(find.text('Dosage'), findsOneWidget);
    expect(find.text('2 pills'), findsOneWidget);
    expect(find.text('Instructions'), findsOneWidget);
    expect(find.text('Take with water'), findsOneWidget);
    expect(find.text('Brand'), findsNothing);
    expect(find.text('Type'), findsNothing);

    // Verify that the Save Changes button is present
    expect(find.widgetWithText(ElevatedButton, 'Save Changes'), findsOneWidget);
  });

  testWidgets('Save Changes button triggers FarmUpdate event and navigates to inventory screen', (WidgetTester tester) async {
    final mockItem = Farm(
      itemName: 'Item 1',
      quantity: '10',
      expirationDate: '2023-06-01',
      dosage: '2 pills',
      instructions: 'Take with water',
      userID: 'user123',
      farmName: 'Farm 1',
      id_: 'item123',
      isfeed: false,
      ismedication: true,
      brand: '',
      type: '',
    );

    when(farmBloc.state).thenReturn(FarmDataLoaded([]));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FarmBloc>.value(
          value: farmBloc,
          child: EditItemScreen(item: mockItem),
        ),
      ),
    );

    // Tap the Save Changes button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Save Changes'));
    await tester.pumpAndSettle();

    // Verify that FarmUpdate event is added to the bloc
    verify(farmBloc.add(FarmUpdate(id: 'item123', farm: mockItem))).called(1);

    // Verify that navigation to inventory screen curs
    expect(find.text('Edit Item'), findsNothing);
    expect(find.text('Inventory'), findsOneWidget);
  });

  testWidgets('Back button navigates to inventory screen', (WidgetTester tester) async {
    final mockItem = Farm(
      itemName: 'Item 1',
      quantity: '10',
      expirationDate: '2023-06-01',
      dosage: '2 pills',
      instructions: 'Take with water',
      userID: 'user123',
      farmName: 'Farm 1',
      id_: 'item123',
      isfeed: false,
      ismedication: true,
      brand: '',
      type: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FarmBloc>.value(
          value: farmBloc,
          child: EditItemScreen(item: mockItem),
        ),
      ),
    );

    // Tap the Back button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Back'));
    await tester.pumpAndSettle();

    // Verify that navigation to inventory screen occurs
    expect(find.text('Edit Item'), findsNothing);
    expect(find.text('Inventory'), findsOneWidget);
  });
}
