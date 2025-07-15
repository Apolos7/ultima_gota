// This is a basic Flutter widget test.
//

import 'package:flutter_test/flutter_test.dart';
import 'package:ultima_gota/app/app.dart';

void main() {
  testWidgets('disable', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
  });
}
