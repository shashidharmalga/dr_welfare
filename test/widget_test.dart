import 'package:flutter_test/flutter_test.dart';

import 'package:drwelfare/main.dart';

void main() {
  testWidgets('Smoke test for DrWelfareApp', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DrWelfareApp());

    // Verify that splash screen content is displayed
    expect(find.text('Doctors Welfare\nTrust India'), findsOneWidget);
    expect(find.text('Excellence in Clinical Care'), findsOneWidget);

    // Settle splash screen transition timers
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pumpAndSettle();
  });
}
