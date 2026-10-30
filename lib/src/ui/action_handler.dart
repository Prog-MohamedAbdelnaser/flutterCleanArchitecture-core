import 'package:flutter/material.dart';

import '../errors/soft_error.dart';
import '../state/data_state.dart';
import 'soft_core_config.dart';

/// Called when an action succeeds, with what the action returned.
typedef ActionSuccessCallback = void Function(
  BuildContext context,
  Object? result,
);

/// Called when an action fails. Replaces the default error message.
typedef ActionErrorCallback = void Function(
  BuildContext context,
  SoftError error,
);

/// The default reaction to [ActionState]s, shared by every softcore widget:
/// a progress dialog while loading, a message on failure, a callback on
/// success.
///
/// Owned by a widget's `State`, so the dialog it opens is the one it
/// closes, even if the widget rebuilds in between.
class ActionHandler {
  NavigatorState? _navigator;
  Route<void>? _progress;

  /// Reacts to [state].
  void handle(
    BuildContext context,
    ActionState<Object?> state, {
    bool showProgress = true,
    ActionSuccessCallback? onSuccess,
    ActionErrorCallback? onError,
  }) {
    final config = SoftCore.read(context);
    switch (state) {
      case ActionLoading():
        if (showProgress) _showProgress(context, config);
      case ActionFailed(:final error):
        _hideProgress();
        final softError = config.errorMapper(context, error);
        if (onError != null) {
          onError(context, softError);
        } else {
          config.showError(context, softError);
        }
      case ActionSuccess(:final result):
        _hideProgress();
        onSuccess?.call(context, result);
      default:
        // Your own ActionState subclasses: handled by your listener.
        break;
    }
  }

  /// Hides the progress dialog, if shown. Call from `dispose`.
  void dispose() => _hideProgress();

  void _showProgress(BuildContext context, SoftCoreConfig config) {
    if (_progress != null) return;
    final navigator = Navigator.maybeOf(context, rootNavigator: true);
    if (navigator == null) return;
    final route = DialogRoute<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black26,
      builder: (context) =>
          PopScope(canPop: false, child: config.buildProgress(context)),
    );
    _navigator = navigator;
    _progress = route;
    navigator.push(route);
  }

  // Removes exactly the route it pushed, never another dialog on top.
  void _hideProgress() {
    final route = _progress;
    final navigator = _navigator;
    _progress = null;
    _navigator = null;
    if (route != null && navigator != null && route.isActive) {
      navigator.removeRoute(route);
    }
  }
}
