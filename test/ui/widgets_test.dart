import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softcore/softcore.dart';

class NamesCubit extends BaseCubit<List<String>> {}

Widget app(Widget child, {SoftCoreConfig? config}) {
  final home = Scaffold(body: child);
  return MaterialApp(
    home: config == null ? home : SoftCore(config: config, child: home),
  );
}

void main() {
  group('SoftBlocConsumer', () {
    testWidgets('renders loading, data and error with retry', (tester) async {
      final cubit = NamesCubit();
      var retries = 0;
      await tester.pumpWidget(app(SoftBlocConsumer<NamesCubit, List<String>>(
        bloc: cubit,
        onRetry: () => retries++,
        builder: (context, names) => Text(names.join(',')),
      )));

      cubit.emitLoading();
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      cubit.emitData(['a', 'b']);
      await tester.pump();
      expect(find.text('a,b'), findsOneWidget);

      cubit.emitError(const SoftException('Offline'));
      await tester.pump();
      expect(find.text('Offline'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      expect(retries, 1);
      await cubit.close();
    });

    testWidgets(
        'keeps data on screen during an action, shows and hides '
        'progress, and calls onActionSuccess', (tester) async {
      final cubit = NamesCubit()..emitData(['a']);
      Object? success;
      await tester.pumpWidget(app(SoftBlocConsumer<NamesCubit, List<String>>(
        bloc: cubit,
        onActionSuccess: (context, result) => success = result,
        builder: (context, names) => Text(names.join(',')),
      )));

      final action = Completer<String>();
      unawaited(cubit.runAction(() => action.future));
      await tester.pump();
      await tester.pump();
      expect(find.text('a'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      action.complete('done');
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('a'), findsOneWidget);
      expect(success, 'done');
      await cubit.close();
    });

    testWidgets(
        'an action error shows a snackbar and a custom listener '
        'still runs after the defaults', (tester) async {
      final cubit = NamesCubit()..emitData(['a']);
      final heard = <DataState<List<String>>>[];
      await tester.pumpWidget(app(SoftBlocConsumer<NamesCubit, List<String>>(
        bloc: cubit,
        listener: (context, state) => heard.add(state),
        builder: (context, names) => Text(names.join(',')),
      )));

      await cubit.runAction<void>(
        () async => throw const SoftException('Not allowed'),
      );
      await tester.pumpAndSettle();
      expect(find.text('Not allowed'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(heard.last, isA<ActionFailed<List<String>>>());
      await cubit.close();
    });

    testWidgets('reads the bloc from context and uses config overrides',
        (tester) async {
      final cubit = NamesCubit();
      await tester.pumpWidget(app(
        BlocProvider.value(
          value: cubit,
          child: SoftBlocConsumer<NamesCubit, List<String>>(
            builder: (context, names) => Text(names.join(',')),
          ),
        ),
        config: SoftCoreConfig(
          loadingBuilder: (_) => const Text('custom loading'),
          errorMapper: (context, error) =>
              const SoftError(message: 'mapped error'),
        ),
      ));

      cubit.emitLoading();
      await tester.pumpAndSettle();
      expect(find.text('custom loading'), findsOneWidget);

      cubit.emitError(Exception('raw'));
      await tester.pumpAndSettle();
      expect(find.text('mapped error'), findsOneWidget);
      await cubit.close();
    });

    testWidgets('renders custom build states with stateBuilder',
        (tester) async {
      final cubit = NamesCubit();
      await tester.pumpWidget(app(SoftBlocConsumer<NamesCubit, List<String>>(
        bloc: cubit,
        stateBuilder: (context, state) =>
            state is NoNames<List<String>> ? const Text('nobody') : null,
        builder: (context, names) => Text(names.join(',')),
      )));
      cubit.emitState(const NoNames<List<String>>());
      await tester.pump();
      expect(find.text('nobody'), findsOneWidget);
      await cubit.close();
    });
  });

  group('your own action states', () {
    testWidgets('reach the listener without touching the screen',
        (tester) async {
      final cubit = NamesCubit()..emitData(['a']);
      final heard = <DataState<List<String>>>[];
      await tester.pumpWidget(app(SoftBlocConsumer<NamesCubit, List<String>>(
        bloc: cubit,
        listener: (context, state) => heard.add(state),
        builder: (context, names) => Text(names.join(',')),
      )));
      cubit.emitState(const Shared<List<String>>());
      await tester.pumpAndSettle();
      expect(heard, [const Shared<List<String>>()]);
      expect(find.text('a'), findsOneWidget);
      expect(cubit.data, ['a']);
      await cubit.close();
    });
  });

  group('SoftBlocListener', () {
    testWidgets('handles actions without rebuilding the child', (tester) async {
      final cubit = NamesCubit();
      Object? success;
      await tester.pumpWidget(app(SoftBlocListener<NamesCubit, List<String>>(
        bloc: cubit,
        onActionSuccess: (context, result) => success = result,
        child: const Text('form'),
      )));
      await cubit.runAction(() async => 42);
      await tester.pumpAndSettle();
      expect(success, 42);
      expect(find.text('form'), findsOneWidget);
      await cubit.close();
    });
  });

  group('DataObserverBuilder', () {
    testWidgets('renders an observer on its own', (tester) async {
      final cubit = NamesCubit();
      final observer = cubit.observer<int>('count');
      await tester.pumpWidget(app(DataObserverBuilder<int>(
        observer: observer,
        builder: (context, count) => Text('count $count'),
      )));
      await observer.load(() async => 7);
      await tester.pump();
      expect(find.text('count 7'), findsOneWidget);
      await cubit.close();
    });
  });

  group('SoftBlocPage', () {
    testWidgets('creates the cubit and loads once, closes it on dispose',
        (tester) async {
      final page = CountingPage();
      await tester.pumpWidget(MaterialApp(home: page));
      await tester.pump();
      expect(find.text('Names'), findsOneWidget);
      expect(find.text('a'), findsOneWidget);

      // Rebuilding the page must not load again.
      await tester.pumpWidget(MaterialApp(home: page));
      await tester.pump();
      expect(page.loads, 1);

      await tester.pumpWidget(const MaterialApp(home: SizedBox()));
      expect(page.created!.isClosed, isTrue);
    });
  });

  group('progress dialog', () {
    testWidgets('closes only its own dialog, not one opened on top',
        (tester) async {
      final cubit = NamesCubit()..emitData(['a']);
      await tester.pumpWidget(app(SoftBlocConsumer<NamesCubit, List<String>>(
        bloc: cubit,
        builder: (context, names) => Text(names.join(',')),
      )));
      final action = Completer<void>();
      unawaited(cubit.runAction(() => action.future));
      await tester.pump();
      await tester.pump();
      unawaited(showDialog<void>(
        context: tester.element(find.text('a')),
        builder: (_) => const Text('other dialog'),
      ));
      // The spinner animates forever, so pump a fixed time, not settle.
      await tester.pump(const Duration(milliseconds: 500));

      action.complete();
      await tester.pumpAndSettle();
      expect(find.text('other dialog'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      await cubit.close();
    });
  });
}

class NoNames<T> extends BuildState<T> {
  const NoNames();
}

class Shared<T> extends ActionState<T> {
  const Shared();

  @override
  bool operator ==(Object other) => other is Shared<T>;

  @override
  int get hashCode => (Shared<T>).hashCode;
}

// ignore: must_be_immutable
class CountingPage extends SoftBlocPage<NamesCubit, List<String>> {
  CountingPage({super.key});

  int loads = 0;
  NamesCubit? created;

  @override
  NamesCubit createBloc(BuildContext context) => created = NamesCubit();

  @override
  void onInit(NamesCubit bloc) {
    loads++;
    bloc.emitData(['a']);
  }

  @override
  String? title(BuildContext context) => 'Names';

  @override
  Widget buildData(BuildContext context, NamesCubit bloc, List<String> data) =>
      Text(data.join(','));
}
