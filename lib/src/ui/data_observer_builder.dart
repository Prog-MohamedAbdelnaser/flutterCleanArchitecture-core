import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/data_observer.dart';
import '../state/data_state.dart';
import 'data_state_view.dart';
import 'soft_core_config.dart';

/// Renders one [DataObserver]: its own loading, error and data, independent
/// of the rest of the screen.
///
/// ```dart
/// DataObserverBuilder<List<Notice>>(
///   observer: cubit.observer('notices'),
///   onRetry: cubit.loadNotices,
///   builder: (context, notices) => NoticesList(notices),
/// )
/// ```
class DataObserverBuilder<T> extends StatelessWidget {
  /// Renders [observer].
  const DataObserverBuilder({
    super.key,
    required this.observer,
    required this.builder,
    this.loadingBuilder,
    this.errorBuilder,
    this.initialBuilder,
    this.onRetry,
  });

  /// The observer to render.
  final DataObserver<T> observer;

  /// Builds the data.
  final DataWidgetBuilder<T> builder;

  /// Overrides the loading view.
  final WidgetBuilder? loadingBuilder;

  /// Overrides the error view.
  final ErrorViewBuilder? errorBuilder;

  /// Overrides the initial view.
  final WidgetBuilder? initialBuilder;

  /// Called by the error view's retry button.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataObserver<T>, DataState<T>>(
      bloc: observer,
      builder: (context, state) => DataStateView<T>(
        state: state,
        builder: builder,
        loadingBuilder: loadingBuilder,
        errorBuilder: errorBuilder,
        initialBuilder: initialBuilder,
        onRetry: onRetry,
      ),
    );
  }
}
