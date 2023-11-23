import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rentbike/main.dart' as app;

void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('AddNewRentModel Integration Test', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    // Assuming the screen starts with empty text fields
    expect(find.text('Nama Penyewa'), findsOneWidget);
    expect(find.text('Data Peminjaman'), findsOneWidget);
    expect(find.text('Kategori'), findsOneWidget);
    expect(find.text('Tanggal'), findsOneWidget);
    expect(find.text('Jam'), findsOneWidget);

    // Fill in the text fields
    await tester.enterText(find.byKey(const Key('Nama Penyewa')), 'John Doe');
    await tester.enterText(
        find.byKey(const Key('Data Peminjaman')), 'Description');

    // Tap the "Simpan" button
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // Verify that the data is saved
    // You need to adjust the below expectations based on your actual UI
    expect(find.text('Data berhasil disimpan'), findsOneWidget);
  });
}
