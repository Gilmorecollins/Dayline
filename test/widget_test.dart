import 'package:flutter_test/flutter_test.dart';

import 'package:dayline/main.dart';
import 'package:dayline/core/store/task_store.dart';
import 'package:dayline/core/store/demo_task_seed.dart';

void main() {
  testWidgets('Dayline app loads without crashing',
      (WidgetTester tester) async {
    final store = TaskStore();
    await seedTaskStoreIfEmpty(store);

    await tester.pumpWidget(DaylineApp(store: store));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);
  });
}
