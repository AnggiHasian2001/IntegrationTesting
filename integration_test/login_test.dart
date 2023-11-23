import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rentbike/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login Integration Test', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    // Tap the "Sign In" button
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    // Verify that we are on the Login screen
    expect(find.text('Login'), findsOneWidget);

    // Fill in the login form
    await tester.enterText(
        find.byKey(const Key('Email')), 'john.doe@example.com');
    await tester.enterText(find.byKey(const Key('Password')), 'password');

    // Tap the "Sign In" button to submit the form
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    // Verify that we are on the HomePage screen after successful login
    expect(find.text('Admin'), findsOneWidget);
  });
}
