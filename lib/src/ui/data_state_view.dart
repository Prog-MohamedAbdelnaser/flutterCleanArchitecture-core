import 'package:flutter/widgets.dart';

import '../state/data_state.dart';
import 'soft_core_config.dart';

/// Builds the widget for data of type [T].
typedef DataWidgetBuilder<T> = Widget Function(BuildContext context, T data);

/// Renders one [DataState]: loading, error, data, initial, or your own.
///
/// The building block behind every softcore widget; use it directly when you
/// already hold a state (e.g. inside your own `BlocBuilder`).
class DataStateView<T> extends StatelessWidget {
  /// Renders [state].
  const DataStateView({
    super.key,
    required this.state,
    required this.builder,
    this.loadingBuilder,
    this.errorBuilder,
    this.initialBuilder,
    this.stateBuilder,
    this.onRetry,
  });

  /// The state to render.
  final DataState<T> state;

  /// Builds the data.
  final DataWidgetBuilder<T> builder;

  /// Overrides the loading view.
  final WidgetBuilder? loadingBuilder;

  /// Overrides the error view.
  final ErrorViewBuilder? errorBuilder;

  /// Overrides the initial view.
  final WidgetBuilder? initialBuilder;

  /// Builds states that are not one of the standard four: your own
  /// [BuildState] subclasses. Returning `null` falls back to the initial
  /// view.
  final Widget? Function(BuildContext context, DataState<T> state)?
      stateBuilder;

  /// Passed to the error view's retry button.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final config = SoftCore.of(context);
    final current = state;
    return switch (current) {
      DataSuccess<T>(:final data) => builder(context, data),
      DataLoading<T>() =>
        loadingBuilder?.call(context) ?? config.buildLoading(context),
      DataFailed<T>(:final error) => _error(context, config, error),
      DataInitial<T>() =>
        initialBuilder?.call(context) ?? config.buildInitial(context),
      _ => stateBuilder?.call(context, current) ??
          initialBuilder?.call(context) ??
          config.buildInitial(context),
    };
  }

  Widget _error(BuildContext context, SoftCoreConfig config, Object error) {
    final softError = config.errorMapper(context, error);
    return errorBuilder?.call(context, softError, onRetry) ??
        config.buildError(context, softError, onRetry);
  }
}
