import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pro/LocalStroe/Store.dart';
import 'package:pro/farm/farm_bloc/farm_event.dart';

import 'package:pro/farm/view/add_item.dart';
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

  testWidgets('AddItemScreen adds item correctly and navigates to inventory screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FarmBloc>.value(
          value: farmBloc,
          child: AddItemScreen(),
        ),
      ),
    );

    // Enter item details in the text fields
    await tester.enterText(find.byKey(const Key('item_name_field')), 'Item 1');
    await tester.enterText(find.byKey(const Key('quantity_field')), '10');
    await tester.enterText(find.byKey(const Key('expiration_date_field')), '2023-06-01');

    // Select item type as "Medication"
    await tester.tap(find.byKey(const Key('item_type_dropdown')));
    await tester.pump();
    await tester.tap(find.text('Medication').last);
    await tester.pump();

    // Enter additional fields for medication type
    await tester.enterText(find.byKey(const Key('dosage_field')), '2 pills');
    await tester.enterText(find.byKey(const Key('instructions_field')), 'Take with water');

    // Tap the "Add Item" button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Add Item'));
    await tester.pumpAndSettle();

    // Verify that FarmCreate event is added to the bloc
    verify(farmBloc.add(FarmCreate(Farm(
      userID: UserPreferences.userId,
      farmName: UserPreferences.farmName,
      id_: '',
      expirationDate: '2023-06-01',
      itemName: 'Item 1',
      dosage: '2 pills',
      instructions: 'Take with water',
      isfeed: false,
      ismedication: true,
      quantity: '10',
      brand: '',
      type: '',
    )))).called(1);

    // Verify that navigation to inventory screen occurs
    expect(find.text('Inventory'), findsOneWidget);
    expect(find.text('Item 1'), findsOneWidget);
  });

  testWidgets('AddItemScreen displays validation errors for empty fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FarmBloc>.value(
          value: farmBloc,
          child: AddItemScreen(),
        ),
      ),
    );

    // Tap the "Add Item" button without entering any details
    await tester.tap(find.widgetWithText(ElevatedButton, 'Add Item'));
    await tester.pumpAndSettle();

    // Verify that validation errors are displayed
    expect(find.text('Please enter your item name'), findsOneWidget);
    expect(find.text('Please enter Quantity'), findsOneWidget);
    expect(find.text('Please enter Expiration date'), findsOneWidget);
  });


}
