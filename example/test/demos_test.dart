import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softcore_example/main.dart';

void main() {
  testWidgets('every demo opens and loads without errors', (tester) async {
    await tester.pumpWidget(const SoftcoreExampleApp());
    for (final demo in demos) {
      await tester.scrollUntilVisible(
        find.text(demo.title).first,
        100,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text(demo.title).first);
      // Let fake requests finish; spinners animate forever, so pump time.
      await tester.pump(const Duration(seconds: 2));
      await tester.pump(const Duration(seconds: 2));
      expect(tester.takeException(), isNull, reason: demo.title);
      await tester.pageBack();
      await tester.pump(const Duration(seconds: 1));
    }
  });
}
