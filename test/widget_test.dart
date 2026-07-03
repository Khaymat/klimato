import 'package:flutter_test/flutter_test.dart';
import 'package:klimato/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(KlimatoApp());
    expect(find.text('Klimato'), findsWidgets);
  });
}
