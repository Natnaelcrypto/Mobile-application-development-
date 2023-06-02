import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:pro/farm/view/item_detail.dart';
import 'package:pro/farm/farm_model/farm_model.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late Farm item;
  late MockNavigatorObserver navigatorObserver;

  setUp(() {
    item = Farm(
      userID: '123',
      farmName: 'Farm 1',
      id_: 'item_1',
      expirationDate: '2023-06-01',
      itemName: 'Item 1',
      dosage: '2 pills',
      instructions: 'Take with water',
      isfeed: false,
      ismedication: true,
      quantity: '10',
      brand: '',
      type: '',
    );
    navigatorObserver = MockNavigatorObserver();
  });

  tearDown(() {
    reset(navigatorObserver);
  });

  testWidgets('ItemDetailScreen displays item details correctly for medication item', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ItemDetailScreen(item: item),
        navigatorObservers: [navigatorObserver],
      ),
    );

    // Verify that the item details are displayed correctly
    expect(find.text('Item Detail'), findsOneWidget);
    expect(find.text('Name: Item 1'), findsOneWidget);
    expect(find.text('Quantity: 10'), findsOneWidget);
    expect(find.text('Expiration Date: 2023-06-01'), findsOneWidget);
    expect(find.text('Dosage: 2 pills'), findsOneWidget);
    expect(find.text('Instructions: Take with water'), findsOneWidget);

    // Verify that the edit button is visible
    expect(find.byIcon(Icons.mode_edit), findsOneWidget);

    // Tap the edit button
    await tester.tap(find.byIcon(Icons.mode_edit));
    await tester.pumpAndSettle();

    // Verify that the navigation to the edit screen occurs
    verify(navigatorObserver.didPush(any!, any));


  });



}
