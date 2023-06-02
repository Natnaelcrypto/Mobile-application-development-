import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pro/main.dart' as app;
import 'package:pro/screens/Error_page.dart';
import 'package:pro/screens/Home.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Add inventory test', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'naty');
    await tester.enterText(find.byType(TextFormField).last, '123456');

    await tester.tap(
      find.byType(TextButton),
    );

    await Future.delayed(const Duration(seconds: 5));

    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.tap(find.byTooltip('Open navigation menu'));
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.tap(
      find.widgetWithText(ListTile, 'Inventory'),
    );
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add).at(0));

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'test');
    await tester.enterText(find.byType(TextFormField).at(1), '20');
    await tester.enterText(find.byType(TextFormField).at(2), '2020-02-20');
    await Future.delayed(const Duration(seconds: 2));
    await tester.tap(find.text("Select Item Type"));
    await Future.delayed(const Duration(seconds: 2));

    await tester.tap(find.text("Medication").first);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.enterText(find.byType(TextFormField).at(4), '30ml/8h');
    await tester.enterText(find.byType(TextFormField).at(5), 'with water');

    await tester.tap(find.text('Add Item'));

    await Future.delayed(const Duration(seconds: 4));

    expect(find.text("Inventory List"), findsOneWidget);
  });
}
