import 'package:flutter_test/flutter_test.dart';
import 'package:numeroloji/app/numerology_app.dart';

void main() {
  testWidgets('Numerology app opens home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const NumerologyApp());

    expect(find.text('NUMEROLOJ\u0130'), findsOneWidget);
    expect(find.text('Numeroloji Hesapla'), findsOneWidget);
  });
}
