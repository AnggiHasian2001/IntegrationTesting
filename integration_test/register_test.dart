import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rentbike/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Register Integration Test', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    // Tap the "Register" button
    await tester.tap(find.text('Registrasi'));
    await tester.pumpAndSettle();

    // Verify that we are on the Register screen
    expect(find.text('Register'), findsOneWidget);

    // Fill in the registration form
    await tester.enterText(find.byKey(const Key('Name')), 'John Doe');
    await tester.enterText(
        find.byKey(const Key('Email')), 'john.doe@example.com');
    await tester.enterText(find.byKey(const Key('Password')), 'password');

    // Tap the "Registrasi" button to submit the form
    await tester.tap(find.text('Registrasi'));
    await tester.pumpAndSettle();

    // Verify that we are back on the Login screen after successful registration
    expect(find.text('Login'), findsOneWidget);
  });
}
