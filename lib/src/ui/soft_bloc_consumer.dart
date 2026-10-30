import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/base_cubit.dart';
import '../state/data_state.dart';
import 'action_handler.dart';
import 'data_state_view.dart';
import 'soft_core_config.dart';

/// Renders a bloc that emits [DataState]s, such as a [BaseCubit], and
/// handles its actions.
///
/// Rebuilds on screen states (loading, error, data, initial, and your own
/// [BuildState] subclasses). Listens to [ActionState]s: shows a progress
/// dialog while an action runs, a message when it fails, and calls
/// [onActionSuccess] when it succeeds.
///
/// ```dart
/// SoftBlocConsumer<UsersCubit, List<User>>(
///   onRetry: () => context.read<UsersCubit>().loadUsers(),
///   builder: (context, users) => UsersList(users),
/// )
/// ```
class SoftBlocConsumer<B extends StateStreamable<DataState<T>>, T>
    extends StatefulWidget {
  /// Creates a consumer for [bloc], or the nearest [B] from the context.
  const SoftBlocConsumer({
    super.key,
    this.bloc,
    required this.builder,
    this.stateBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.initialBuilder,
    this.onRetry,
    this.listener,
    this.onActionSuccess,
    this.onActionError,
    this.showProgress = true,
  });

  /// The bloc; read from the context when `null`.
  final B? bloc;

  /// Builds the data.
  final DataWidgetBuilder<T> builder;

  /// Builds your own [BuildState] subclasses. Return `null` for the
  /// initial view.
  final Widget? Function(BuildContext context, DataState<T> state)?
      stateBuilder;

  /// Overrides the loading view.
  final WidgetBuilder? loadingBuilder;

  /// Overrides the error view.
  final ErrorViewBuilder? errorBuilder;

  /// Overrides the initial view.
  final WidgetBuilder? initialBuilder;

  /// Called by the error view's retry button.
  final VoidCallback? onRetry;

  /// Called for every action state, including your own [ActionState]
  /// subclasses, *after* the default handling, so adding a listener never
  /// turns off progress or error messages.
  final BlocWidgetListener<DataState<T>>? listener;

  /// Called when an action succeeds.
  final ActionSuccessCallback? onActionSuccess;

  /// Called when an action fails, instead of the default error message.
  final ActionErrorCallback? onActionError;

  /// Whether to show a progress dialog while an action runs. Turn it off to
  /// show your own inline indicator instead.
  final bool showProgress;

  @override
  State<SoftBlocConsumer<B, T>> createState() => _SoftBlocConsumerState<B, T>();
}

class _SoftBlocConsumerState<B extends StateStreamable<DataState<T>>, T>
    extends State<SoftBlocConsumer<B, T>> {
  final ActionHandler _actions = ActionHandler();

  @override
  void dispose() {
    _actions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = widget.bloc ?? context.read<B>();
    return BlocConsumer<B, DataState<T>>(
      bloc: bloc,
      buildWhen: (previous, current) => current is! ActionState<T>,
      listenWhen: (previous, current) => current is ActionState<T>,
      listener: (context, state) {
        _actions.handle(
          context,
          state as ActionState<T>,
          showProgress: widget.showProgress,
          onSuccess: widget.onActionSuccess,
          onError: widget.onActionError,
        );
        widget.listener?.call(context, state);
      },
      builder: (context, state) => DataStateView<T>(
        // The first build can land mid-action; show what was on screen.
        state: state is ActionState<T> ? _lastBuildState(bloc) : state,
        builder: widget.builder,
        loadingBuilder: widget.loadingBuilder,
        errorBuilder: widget.errorBuilder,
        initialBuilder: widget.initialBuilder,
        onRetry: widget.onRetry,
        stateBuilder: widget.stateBuilder,
      ),
    );
  }

  DataState<T> _lastBuildState(B bloc) {
    final Object source = bloc;
    return source is BaseCubit<T> ? source.buildState : DataInitial<T>();
  }
}
