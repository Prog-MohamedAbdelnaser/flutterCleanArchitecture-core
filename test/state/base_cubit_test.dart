import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softcore/softcore.dart';

class CounterCubit extends BaseCubit<int> {
  CounterCubit();

  final List<Object> errors = [];

  @override
  void onError(Object error, StackTrace stackTrace) {
    errors.add(error);
    super.onError(error, stackTrace);
  }
}

void main() {
  group('load', () {
    blocTest<CounterCubit, DataState<int>>(
      'emits loading then success',
      build: CounterCubit.new,
      act: (cubit) => cubit.load(() async => 1),
      expect: () => const [DataLoading<int>(), DataSuccess<int>(1)],
      verify: (cubit) => expect(cubit.data, 1),
    );

    blocTest<CounterCubit, DataState<int>>(
      'emits loading then failure and reports the error',
      build: CounterCubit.new,
      act: (cubit) => cubit.load(() async => throw Exception('boom')),
      expect: () => [
        const DataLoading<int>(),
        isA<DataFailed<int>>(),
      ],
      verify: (cubit) => expect(cubit.errors, hasLength(1)),
    );

    test('a slow earlier request never overwrites a newer one', () async {
      final cubit = CounterCubit();
      final slow = Completer<int>();
      final first = cubit.load(() => slow.future);
      await cubit.load(() async => 2);
      slow.complete(1);
      await first;
      expect(cubit.state, const DataSuccess<int>(2));
      await cubit.close();
    });

    test('emitData cancels a load in flight', () async {
      final cubit = CounterCubit();
      final slow = Completer<int>();
      final pending = cubit.load(() => slow.future);
      cubit.emitData(5);
      slow.complete(1);
      await pending;
      expect(cubit.state, const DataSuccess<int>(5));
      await cubit.close();
    });

    test('does not emit after close', () async {
      final cubit = CounterCubit();
      final slow = Completer<int>();
      final pending = cubit.load(() => slow.future);
      await cubit.close();
      slow.complete(1);
      await expectLater(pending, completes);
    });

    test('keepDataWhileLoading skips the loading state', () async {
      final cubit = CounterCubit()..emitData(1);
      final states = <DataState<int>>[];
      final sub = cubit.stream.listen(states.add);
      await cubit.load(() async => 2, keepDataWhileLoading: true);
      await Future<void>.delayed(Duration.zero);
      expect(states, const [DataSuccess<int>(2)]);
      await sub.cancel();
      await cubit.close();
    });
  });

  group('cache', () {
    test('a cached value is reused until forceRefresh', () async {
      final cubit = CounterCubit();
      var calls = 0;
      Future<int> request() async => ++calls;

      await cubit.load(request, cacheKey: 'count');
      await cubit.load(request, cacheKey: 'count');
      expect(calls, 1);
      expect(cubit.data, 1);

      await cubit.load(request, cacheKey: 'count', forceRefresh: true);
      expect(calls, 2);
      expect(cubit.data, 2);
      await cubit.close();
    });

    test('expired entries are dropped', () async {
      final cache = SoftCache()
        ..write('a', 1, ttl: const Duration(milliseconds: 1));
      await Future<void>.delayed(const Duration(milliseconds: 5));
      expect(cache.read<int>('a'), isNull);
      expect(cache.contains('a'), isFalse);
    });

    test('read with the wrong type returns null', () {
      final cache = SoftCache()..write('a', 'text');
      expect(cache.read<int>('a'), isNull);
    });
  });

  group('runAction', () {
    blocTest<CounterCubit, DataState<int>>(
      'emits action loading then success with the result',
      build: CounterCubit.new,
      act: (cubit) => cubit.runAction(() async => 'saved'),
      expect: () => const [ActionLoading<int>(), ActionSuccess<int>('saved')],
    );

    test('a failure is emitted, returned, and does not throw', () async {
      final cubit = CounterCubit();
      final result = await cubit.runAction<String>(() async => throw 'nope');
      expect(result.isFailure, isTrue);
      expect(result.error, 'nope');
      expect(cubit.state, const ActionFailed<int>('nope'));
      expect(cubit.errors, ['nope']);
      await cubit.close();
    });

    test('keeps buildState while the action runs', () async {
      final cubit = CounterCubit()..emitData(3);
      await cubit.runAction(() async => true);
      expect(cubit.state, isA<ActionSuccess<int>>());
      expect(cubit.buildState, const DataSuccess<int>(3));
      expect(cubit.data, 3);
      await cubit.close();
    });

    test('returns the value on success', () async {
      final cubit = CounterCubit();
      final result = await cubit.runAction(() async => 'ok');
      expect(result.isSuccess, isTrue);
      expect(result.value, 'ok');
      await cubit.close();
    });

    test('infers the result type even when returned as Future<void>', () async {
      final cubit = CounterCubit()..emitData(1);
      Future<void> add() => cubit.runAction(
            () async => 2,
            onSuccess: (n) => cubit.updateData((current) => current + n),
          );
      await add();
      expect(cubit.data, 3);
      await cubit.close();
    });

    test('onSuccess can update the data', () async {
      final cubit = CounterCubit()..emitData(1);
      await cubit.runAction(
        () async => 10,
        onSuccess: (added) => cubit.updateData((n) => n + added),
      );
      expect(cubit.data, 11);
      await cubit.close();
    });
  });

  group('managing state by hand', () {
    test('updateData does nothing without data', () async {
      final cubit = CounterCubit()..updateData((n) => n + 1);
      expect(cubit.state, const DataInitial<int>());
      await cubit.close();
    });

    test('emitState accepts custom states', () async {
      final cubit = CounterCubit()..emitState(const Empty<int>());
      expect(cubit.state, const Empty<int>());
      expect(cubit.buildState, const Empty<int>());
      await cubit.close();
    });
  });

  group('observers', () {
    test('observe loads into an independent observer', () async {
      final cubit = CounterCubit();
      final observer = cubit.observe<String>('name', () async => 'Ali');
      expect(observer.state, const DataLoading<String>());
      await expectLater(
          observer.stream, emits(const DataSuccess<String>('Ali')));
      expect(cubit.state, const DataInitial<int>());
      expect(identical(cubit.observer<String>('name'), observer), isTrue);
      await cubit.close();
    });

    test('reusing a tag with another type throws', () async {
      final cubit = CounterCubit()..observer<String>('x');
      expect(() => cubit.observer<int>('x'), throwsStateError);
      await cubit.close();
    });

    test('closing the cubit closes its observers', () async {
      final cubit = CounterCubit();
      final observer = cubit.observer<int>('x');
      await cubit.close();
      expect(observer.isClosed, isTrue);
    });
  });

  group('DataState', () {
    test('equality and helpers', () {
      expect(const DataSuccess<int>(1), const DataSuccess<int>(1));
      expect(const DataSuccess<int>(1), isNot(const DataSuccess<int>(2)));
      expect(const DataSuccess<int>(1).dataOrNull, 1);
      expect(const DataLoading<int>().dataOrNull, isNull);
    });
  });
}

class Empty<T> extends BuildState<T> {
  const Empty();

  @override
  bool operator ==(Object other) => other is Empty<T>;

  @override
  int get hashCode => (Empty<T>).hashCode;
}
