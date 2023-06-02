import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pro/main.dart' as app;
import 'package:pro/screens/Error_page.dart';
import 'package:pro/screens/Home.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Emplooye List load test', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'naty');
    await tester.enterText(find.byType(TextFormField).last, '123456');

    await tester.tap(
      find.byType(TextButton),
    );

    await Future.delayed(const Duration(seconds: 5));

    await tester.pumpAndSettle();

    await tester.tap(
      find.byIcon(Icons.person_2_outlined),
    );
    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.enterText(find.byType(TextFormField).at(0), 'naty');
    await tester.enterText(find.byType(TextFormField).at(1), 'yoh');
    await tester.enterText(find.byType(TextFormField).at(2), 'naty');
    await tester.enterText(find.byType(TextFormField).at(3), '123456');
    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.tap(
      find.text("Save Changes"),
    );

    await Future.delayed(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text("Herd Master"), findsOneWidget);
  });
}
