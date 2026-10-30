import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/data_state.dart';
import 'action_handler.dart';

/// Handles a bloc's actions without rendering its data: progress while an
/// action runs, a message when it fails, [onActionSuccess] when it succeeds.
///
/// Use it around forms and buttons whose screen is not driven by the bloc:
///
/// ```dart
/// SoftBlocListener<LoginCubit, void>(
///   onActionSuccess: (context, _) => Navigator.of(context).pop(),
///   child: LoginForm(),
/// )
/// ```
class SoftBlocListener<B extends StateStreamable<DataState<T>>, T>
    extends StatefulWidget {
  /// Listens to [bloc], or the nearest [B] from the context.
  const SoftBlocListener({
    super.key,
    this.bloc,
    required this.child,
    this.listener,
    this.onActionSuccess,
    this.onActionError,
    this.showProgress = true,
  });

  /// The bloc; read from the context when `null`.
  final B? bloc;

  /// The widget below.
  final Widget child;

  /// Called for every action state, after the default handling.
  final BlocWidgetListener<DataState<T>>? listener;

  /// Called when an action succeeds.
  final ActionSuccessCallback? onActionSuccess;

  /// Called when an action fails, instead of the default error message.
  final ActionErrorCallback? onActionError;

  /// Whether to show a progress dialog while an action runs.
  final bool showProgress;

  @override
  State<SoftBlocListener<B, T>> createState() => _SoftBlocListenerState<B, T>();
}

class _SoftBlocListenerState<B extends StateStreamable<DataState<T>>, T>
    extends State<SoftBlocListener<B, T>> {
  final ActionHandler _actions = ActionHandler();

  @override
  void dispose() {
    _actions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, DataState<T>>(
      bloc: widget.bloc ?? context.read<B>(),
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
      child: widget.child,
    );
  }
}
