import 'package:meta/meta.dart';

/// Base type of every state a softcore bloc emits.
///
/// States come in two families:
///
/// * [BuildState] - what the screen shows (initial, loading, data, error).
///   Widgets rebuild on these.
/// * [ActionState] - one-shot events for a user action (submitting a form,
///   deleting an item). Widgets *listen* to these to show progress, a
///   message, or navigate, but never rebuild on them, so the data on screen
///   stays put while an action runs.
///
/// Both families are open: extend [BuildState] or [ActionState] to add your
/// own states and handle them with `stateBuilder` / `listener` on the
/// softcore widgets.
@immutable
abstract class DataState<T> {
  /// Const constructor for subclasses.
  const DataState();
}

/// A state the UI renders. Extend it to add your own screen states.
abstract class BuildState<T> extends DataState<T> {
  /// Const constructor for subclasses.
  const BuildState();
}

/// A one-shot state for a user action. Extend it to add your own events.
abstract class ActionState<T> extends DataState<T> {
  /// Const constructor for subclasses.
  const ActionState();
}

/// Nothing has been requested yet.
final class DataInitial<T> extends BuildState<T> {
  /// Creates the initial state.
  const DataInitial();

  @override
  bool operator ==(Object other) => other is DataInitial<T>;

  @override
  int get hashCode => (DataInitial<T>).hashCode;

  @override
  String toString() => 'DataInitial<$T>()';
}

/// Data is being loaded.
final class DataLoading<T> extends BuildState<T> {
  /// Creates the loading state.
  const DataLoading();

  @override
  bool operator ==(Object other) => other is DataLoading<T>;

  @override
  int get hashCode => (DataLoading<T>).hashCode;

  @override
  String toString() => 'DataLoading<$T>()';
}

/// Data loaded successfully.
final class DataSuccess<T> extends BuildState<T> {
  /// Creates a success state holding [data].
  const DataSuccess(this.data);

  /// The loaded data.
  final T data;

  @override
  bool operator ==(Object other) =>
      other is DataSuccess<T> && other.data == data;

  @override
  int get hashCode => Object.hash(DataSuccess<T>, data);

  @override
  String toString() => 'DataSuccess<$T>($data)';
}

/// Loading data failed.
final class DataFailed<T> extends BuildState<T> {
  /// Creates a failure state for [error].
  const DataFailed(this.error, [this.stackTrace]);

  /// What went wrong. Turned into a message by the configured `ErrorMapper`.
  final Object error;

  /// Where it went wrong, if known.
  final StackTrace? stackTrace;

  @override
  bool operator ==(Object other) =>
      other is DataFailed<T> && other.error == error;

  @override
  int get hashCode => Object.hash(DataFailed<T>, error);

  @override
  String toString() => 'DataFailed<$T>($error)';
}

/// An action started.
final class ActionLoading<T> extends ActionState<T> {
  /// Creates the action-started state.
  const ActionLoading();

  @override
  bool operator ==(Object other) => other is ActionLoading<T>;

  @override
  int get hashCode => (ActionLoading<T>).hashCode;

  @override
  String toString() => 'ActionLoading<$T>()';
}

/// An action finished successfully.
///
/// [result] is whatever the action returned. Its type is not tied to the
/// screen's data type [T], because one screen runs many kinds of actions.
final class ActionSuccess<T> extends ActionState<T> {
  /// Creates an action-success state carrying the action's [result].
  const ActionSuccess([this.result]);

  /// What the action returned.
  final Object? result;

  @override
  bool operator ==(Object other) =>
      other is ActionSuccess<T> && other.result == result;

  @override
  int get hashCode => Object.hash(ActionSuccess<T>, result);

  @override
  String toString() => 'ActionSuccess<$T>($result)';
}

/// An action failed.
final class ActionFailed<T> extends ActionState<T> {
  /// Creates an action-failure state for [error].
  const ActionFailed(this.error, [this.stackTrace]);

  /// What went wrong.
  final Object error;

  /// Where it went wrong, if known.
  final StackTrace? stackTrace;

  @override
  bool operator ==(Object other) =>
      other is ActionFailed<T> && other.error == error;

  @override
  int get hashCode => Object.hash(ActionFailed<T>, error);

  @override
  String toString() => 'ActionFailed<$T>($error)';
}

/// Convenience accessors on any [DataState].
///
/// For everything else, use Dart's `switch` and `is`:
///
/// ```dart
/// final label = switch (state) {
///   DataLoading() => 'Loading',
///   DataSuccess(:final data) => 'Got $data',
///   DataFailed(:final error) => 'Failed: $error',
///   _ => '',
/// };
/// ```
extension DataStateX<T> on DataState<T> {
  /// The data if this is [DataSuccess], otherwise `null`.
  T? get dataOrNull => switch (this) {
        DataSuccess<T>(:final data) => data,
        _ => null,
      };
}
