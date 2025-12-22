import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dayline/main.dart';

void main() {
  testWidgets('Dayline app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const DaylineApp());

    // Verify that the app loads a widget tree
    expect(find.byType(Placeholder), findsOneWidget);
  });
}
