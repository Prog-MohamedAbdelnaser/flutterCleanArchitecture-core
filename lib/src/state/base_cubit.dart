import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'action_result.dart';
import 'data_observer.dart';
import 'data_state.dart';
import 'soft_cache.dart';

/// A [Cubit] for screens that load data of type [T] and run actions.
///
/// * [load] fetches the screen's data: emits [DataLoading], then
///   [DataSuccess] or [DataFailed]. Concurrent loads are safe: only the
///   latest one's result is emitted.
/// * [runAction] runs a one-shot action (submit, delete, like): emits
///   [ActionLoading], then [ActionSuccess] or [ActionFailed]. Errors never
///   escape as unhandled exceptions.
/// * The `emit*` helpers and [updateData] let you manage the state yourself.
/// * [observe] gives a section of the screen its own independent state.
///
/// Every error from [load] and [runAction] goes through `onError`, so
/// override it (calling super) to log or report errors.
///
/// Nothing is emitted after [close], so late responses are harmless.
abstract class BaseCubit<T> extends Cubit<DataState<T>> {
  /// Creates the cubit, starting at [initialState] (default [DataInitial]).
  BaseCubit([DataState<T>? initialState])
      : super(initialState ?? DataInitial<T>()) {
    final initial = state;
    if (initial is BuildState<T>) _buildState = initial;
  }

  /// In-memory cache used by [load] and [observe].
  @protected
  final SoftCache cache = SoftCache();

  final Map<String, DataObserver<Object?>> _observers = {};
  BuildState<T> _buildState = DataInitial<T>();
  int _loadRequest = 0;

  /// The last state the screen rendered.
  ///
  /// While an action runs, [state] is an [ActionState], but the screen is
  /// still showing this one. Use it to read the current data mid-action.
  BuildState<T> get buildState => _buildState;

  /// The data on screen, or `null` if not loaded.
  T? get data => _buildState.dataOrNull;

  // ---------------------------------------------------------------------
  // Loading the screen's data
  // ---------------------------------------------------------------------

  /// Loads the screen's data with [request].
  ///
  /// With [cacheKey], a cached value is shown without calling [request]
  /// (unless [forceRefresh]) and successful results are cached, optionally
  /// for [cacheTtl]. With [keepDataWhileLoading], the current data stays on
  /// screen during a refresh instead of a loading view.
  Future<void> load(
    Future<T> Function() request, {
    String? cacheKey,
    Duration? cacheTtl,
    bool forceRefresh = false,
    bool keepDataWhileLoading = false,
  }) async {
    final id = ++_loadRequest;
    if (cacheKey != null && !forceRefresh && cache.contains(cacheKey)) {
      _setBuild(DataSuccess<T>(cache.read<T>(cacheKey) as T));
      return;
    }
    if (!(keepDataWhileLoading && _buildState is DataSuccess<T>)) {
      _setBuild(DataLoading<T>());
    }
    try {
      final result = await request();
      if (id != _loadRequest) return;
      if (cacheKey != null) cache.write(cacheKey, result, ttl: cacheTtl);
      _setBuild(DataSuccess<T>(result));
    } catch (error, stackTrace) {
      if (id != _loadRequest) return;
      onError(error, stackTrace);
      _setBuild(DataFailed<T>(error, stackTrace));
    }
  }

  Future<R> _cached<R>(
    Future<R> Function() request, {
    String? cacheKey,
    Duration? cacheTtl,
    bool forceRefresh = false,
  }) async {
    if (cacheKey != null && !forceRefresh && cache.contains(cacheKey)) {
      return cache.read<R>(cacheKey) as R;
    }
    final result = await request();
    if (cacheKey != null) cache.write(cacheKey, result, ttl: cacheTtl);
    return result;
  }

  // ---------------------------------------------------------------------
  // One-shot actions
  // ---------------------------------------------------------------------

  /// Runs a one-shot [action] and returns its [ActionResult].
  ///
  /// Emits [ActionLoading], then [ActionSuccess] with the result or
  /// [ActionFailed] with the error. Widgets show a progress indicator and an
  /// error message for these by default. With [onSuccess], you can update
  /// the screen's data from the result (see [updateData]).
  Future<ActionResult<R>> runAction<R>(
    Future<R> Function() action, {
    void Function(R result)? onSuccess,
  }) async {
    _emitIfOpen(ActionLoading<T>());
    try {
      final result = await action();
      onSuccess?.call(result);
      _emitIfOpen(ActionSuccess<T>(result));
      return ActionResult<R>.success(result);
    } catch (error, stackTrace) {
      onError(error, stackTrace);
      _emitIfOpen(ActionFailed<T>(error, stackTrace));
      return ActionResult<R>.failure(error, stackTrace);
    }
  }

  // ---------------------------------------------------------------------
  // Managing the state yourself
  // ---------------------------------------------------------------------

  /// Shows [DataLoading].
  void emitLoading() => _emitBuild(DataLoading<T>());

  /// Shows [data].
  void emitData(T data) => _emitBuild(DataSuccess<T>(data));

  /// Shows [error].
  void emitError(Object error, [StackTrace? stackTrace]) =>
      _emitBuild(DataFailed<T>(error, stackTrace));

  /// Changes the data on screen without a request, e.g. to append an item
  /// or flip a flag after an action. Does nothing if no data is loaded.
  void updateData(T Function(T current) update) {
    final current = _buildState;
    if (current is DataSuccess<T>) {
      _setBuild(DataSuccess<T>(update(current.data)));
    }
  }

  /// Emits any state, including your own [BuildState]/[ActionState]
  /// subclasses. Cancels any [load] in flight when [state] is a
  /// [BuildState], so a late response does not overwrite it.
  void emitState(DataState<T> state) {
    if (state is BuildState<T>) {
      _emitBuild(state);
    } else {
      _emitIfOpen(state);
    }
  }

  // ---------------------------------------------------------------------
  // Observers
  // ---------------------------------------------------------------------

  /// Returns the observer for [tag], creating it on first use.
  ///
  /// Throws a [StateError] if [tag] was already used with another type.
  DataObserver<R> observer<R>(String tag) {
    final existing = _observers[tag];
    if (existing == null) {
      final created = DataObserver<R>();
      _observers[tag] = created as DataObserver<Object?>;
      return created;
    }
    if (existing is! DataObserver<R>) {
      throw StateError(
        'Observer "$tag" is a ${existing.runtimeType}, not DataObserver<$R>.',
      );
    }
    return existing;
  }

  /// Loads [request] into the observer for [tag] and returns the observer.
  ///
  /// With [cacheKey], a cached value is used unless [forceRefresh].
  DataObserver<R> observe<R>(
    String tag,
    Future<R> Function() request, {
    String? cacheKey,
    Duration? cacheTtl,
    bool forceRefresh = false,
  }) {
    final target = observer<R>(tag);
    unawaited(target.load(() => _cached<R>(
          request,
          cacheKey: cacheKey,
          cacheTtl: cacheTtl,
          forceRefresh: forceRefresh,
        )));
    return target;
  }

  // ---------------------------------------------------------------------
  // Hooks and lifecycle
  // ---------------------------------------------------------------------

  @override
  Future<void> close() async {
    for (final observer in _observers.values) {
      await observer.close();
    }
    _observers.clear();
    cache.clear();
    return super.close();
  }

  /// Emits a build state set from outside [load], cancelling any load in
  /// flight so its late result does not overwrite this one.
  void _emitBuild(BuildState<T> state) {
    _loadRequest++;
    _setBuild(state);
  }

  void _setBuild(BuildState<T> state) {
    _buildState = state;
    _emitIfOpen(state);
  }

  void _emitIfOpen(DataState<T> state) {
    if (!isClosed) emit(state);
  }
}
