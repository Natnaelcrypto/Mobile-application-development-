import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pro/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Signup integration test', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    await tester.tap(
      find.byType(ElevatedButton).at(0),
    );

    // await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));

    await tester.enterText(find.byType(TextFormField).at(0), 'naty222');
    await tester.enterText(find.byType(TextFormField).at(1), 'yoh222');
    await tester.enterText(find.byType(TextFormField).at(2), 'nnn222');
    await tester.enterText(find.byType(TextFormField).at(3), '12345622');
    await tester.enterText(find.byType(TextFormField).at(4), '12345622');
    await tester.enterText(find.byType(TextFormField).at(5), 'Farm22');

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -200));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign Up').at(0), warnIfMissed: true);

    await Future.delayed(const Duration(seconds: 7));
    await tester.pump();

    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3));

    expect(find.text("Herd Master"), findsOneWidget);
  });
}
