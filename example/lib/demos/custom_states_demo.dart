import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softcore/softcore.dart';

import 'demo_scaffold.dart';

/// 7. Your own states: extend BuildState for things the screen shows, and
/// ActionState for one-shot events. Emit them with emitState; no mapping or
/// registration needed.

// ---------------------------------------------------------------------------
// Screen states (BuildState): the widget rebuilds and draws them with
// `stateBuilder`.
// ---------------------------------------------------------------------------

/// The cart has no items.
class CartEmpty extends BuildState<List<String>> {
  const CartEmpty();
}

/// The order was placed; the screen shows a confirmation instead of the cart.
class CartCheckedOut extends BuildState<List<String>> {
  const CartCheckedOut(this.orderNumber);

  final int orderNumber;
}

// ---------------------------------------------------------------------------
// Action states (ActionState): one-shot events. The widget does not rebuild,
// so the cart stays on screen; they arrive in `listener`.
// ---------------------------------------------------------------------------

/// A coupon was applied.
class CouponApplied extends ActionState<List<String>> {
  const CouponApplied(this.percent);

  final int percent;
}

/// The user tried to add more than the cart allows.
class CartLimitReached extends ActionState<List<String>> {
  const CartLimitReached(this.limit);

  final int limit;
}

// ---------------------------------------------------------------------------
// The cubit: plain methods that pick which state to emit.
// ---------------------------------------------------------------------------

class CartCubit extends BaseCubit<List<String>> {
  CartCubit() : super(const CartEmpty());

  static const limit = 5;
  static const prices = {'Coffee': 4, 'Tea': 3, 'Cake': 6, 'Juice': 5};

  int discountPercent = 0;

  int get total {
    final items = data ?? const <String>[];
    final sum = items.fold(0, (sum, item) => sum + prices[item]!);
    return sum - sum * discountPercent ~/ 100;
  }

  void add(String item) {
    final items = data;
    if (items == null) {
      emitData([item]);
    } else if (items.length >= limit) {
      emitState(const CartLimitReached(limit)); // the cart stays on screen
    } else {
      updateData((items) => [...items, item]);
    }
  }

  void removeLast() {
    final items = data;
    if (items == null) return;
    if (items.length == 1) {
      emitState(const CartEmpty());
    } else {
      updateData((items) => items.sublist(0, items.length - 1));
    }
  }

  void applyCoupon() {
    if (data == null) return;
    discountPercent = 20;
    emitState(const CouponApplied(20)); // a toast, no rebuild
    updateData((items) => [...items]); // refresh the total
  }

  void checkout() {
    if (data == null) return;
    discountPercent = 0;
    emitState(CartCheckedOut(1000 + DateTime.now().second));
  }

  void startOver() => emitState(const CartEmpty());
}

// ---------------------------------------------------------------------------
// The screen: stateBuilder draws your screen states, listener reacts to your
// action states, builder draws the data as usual.
// ---------------------------------------------------------------------------

class CustomStatesDemo extends StatelessWidget {
  const CustomStatesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<CartCubit>();
        return DemoScaffold(
          title: 'Your own states',
          explanation: 'CartEmpty and CartCheckedOut extend BuildState, so the '
              'screen changes. CouponApplied and CartLimitReached extend '
              'ActionState, so they show a message and the cart stays. Add '
              'more than 5 items to hit the limit.',
          body: Column(
            children: [
              Wrap(
                spacing: 8,
                children: [
                  for (final product in CartCubit.prices.keys)
                    ActionChip(
                      label: Text('+ $product'),
                      onPressed: () => cubit.add(product),
                    ),
                ],
              ),
              const Divider(),
              Expanded(
                child: SoftBlocConsumer<CartCubit, List<String>>(
                  // Your screen states.
                  stateBuilder: (context, state) => switch (state) {
                    CartEmpty() => const Center(
                        child: Text('Your cart is empty. Add something above.'),
                      ),
                    CartCheckedOut(:final orderNumber) => _Confirmation(
                        orderNumber: orderNumber,
                        onStartOver: cubit.startOver,
                      ),
                    _ => null,
                  },
                  // Your action states.
                  listener: (context, state) {
                    final message = switch (state) {
                      CouponApplied(:final percent) => '$percent% off applied',
                      CartLimitReached(:final limit) =>
                        'A cart holds at most $limit items',
                      _ => null,
                    };
                    if (message != null) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(content: Text(message)));
                    }
                  },
                  // The data, as usual.
                  builder: (context, items) => _Cart(
                    items: items,
                    total: cubit.total,
                    discountPercent: cubit.discountPercent,
                    onRemoveLast: cubit.removeLast,
                    onCoupon: cubit.applyCoupon,
                    onCheckout: cubit.checkout,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _Cart extends StatelessWidget {
  const _Cart({
    required this.items,
    required this.total,
    required this.discountPercent,
    required this.onRemoveLast,
    required this.onCoupon,
    required this.onCheckout,
  });

  final List<String> items;
  final int total;
  final int discountPercent;
  final VoidCallback onRemoveLast;
  final VoidCallback onCoupon;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              for (final item in items)
                ListTile(
                  title: Text(item),
                  trailing: Text('\$${CartCubit.prices[item]}'),
                ),
            ],
          ),
        ),
        ListTile(
          title: Text('Total: \$$total'),
          subtitle: discountPercent > 0 ? Text('$discountPercent% off') : null,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            children: [
              TextButton(
                onPressed: onRemoveLast,
                child: const Text('Remove last'),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: discountPercent > 0 ? null : onCoupon,
                child: const Text('Coupon'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: onCheckout,
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Confirmation extends StatelessWidget {
  const _Confirmation({required this.orderNumber, required this.onStartOver});

  final int orderNumber;
  final VoidCallback onStartOver;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline, size: 64),
          const SizedBox(height: 12),
          Text('Order #$orderNumber placed',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          FilledButton.tonal(
            onPressed: onStartOver,
            child: const Text('Start over'),
          ),
        ],
      ),
    );
  }
}
