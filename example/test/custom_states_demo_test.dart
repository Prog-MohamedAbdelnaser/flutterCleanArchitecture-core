import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softcore_example/demos/custom_states_demo.dart';

void main() {
  Future<void> tapText(WidgetTester tester, String text) async {
    await tester.tap(find.text(text));
    await tester.pumpAndSettle();
  }

  testWidgets('custom build and action states drive the cart demo',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CustomStatesDemo()));

    // CartEmpty (BuildState) is drawn by stateBuilder.
    expect(find.textContaining('Your cart is empty'), findsOneWidget);

    await tapText(tester, '+ Coffee');
    await tapText(tester, '+ Cake');
    expect(find.text('Total: \$10'), findsOneWidget);

    // CouponApplied (ActionState) reaches the listener; the cart stays.
    await tapText(tester, 'Coupon');
    expect(find.text('20% off applied'), findsOneWidget);
    expect(find.text('Total: \$8'), findsOneWidget);

    // CartLimitReached (ActionState) after 5 items; still 5 in the cart.
    for (var i = 0; i < 4; i++) {
      await tapText(tester, '+ Tea');
    }
    expect(find.text('A cart holds at most 5 items'), findsOneWidget);
    // Coffee 4 + Cake 6 + 3 Tea x 3 = 19, minus 20% (integer) = 16.
    expect(find.text('Total: \$16'), findsOneWidget);

    // Let the snackbar time out; it covers the buttons.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    // CartCheckedOut (BuildState) replaces the cart with a confirmation.
    await tapText(tester, 'Checkout');
    expect(find.textContaining('placed'), findsOneWidget);

    await tapText(tester, 'Start over');
    expect(find.textContaining('Your cart is empty'), findsOneWidget);
  });
}
