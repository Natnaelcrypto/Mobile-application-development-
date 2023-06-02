import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pro/main.dart' as app;
import 'package:pro/screens/Error_page.dart';
import 'package:pro/screens/Home.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login integration test', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'noaccount');
    await tester.enterText(find.byType(TextFormField).last, '123456');

    await tester.tap(
      find.byType(TextButton),
    );

    await Future.delayed(const Duration(seconds: 5));

    await tester.pumpAndSettle();

    expect(find.text("Login Error"), findsOneWidget);
  });
}
