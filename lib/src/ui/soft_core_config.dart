import 'package:flutter/material.dart';

import '../errors/soft_error.dart';
import 'default_views.dart';

/// Builds the view for an error, with [onRetry] when retrying is possible.
typedef ErrorViewBuilder = Widget Function(
  BuildContext context,
  SoftError error,
  VoidCallback? onRetry,
);

/// Tells the user an action failed (a snackbar by default).
typedef ErrorMessenger = void Function(BuildContext context, SoftError error);

/// App-wide defaults for every softcore widget.
///
/// Provide it once above your app with [SoftCore]; any widget can still
/// override a single builder for itself.
@immutable
class SoftCoreConfig {
  /// Creates a config; anything left `null` uses the built-in default.
  const SoftCoreConfig({
    this.errorMapper = defaultErrorMapper,
    this.loadingBuilder,
    this.errorBuilder,
    this.initialBuilder,
    this.progressBuilder,
    this.errorMessenger,
    this.retryLabel = 'Retry',
  });

  /// Turns thrown errors into displayable [SoftError]s.
  final ErrorMapper errorMapper;

  /// The loading view. Defaults to a centered spinner.
  final WidgetBuilder? loadingBuilder;

  /// The error view. Defaults to [SoftErrorView].
  final ErrorViewBuilder? errorBuilder;

  /// The view before anything is loaded. Defaults to empty.
  final WidgetBuilder? initialBuilder;

  /// The content of the dialog shown while an action runs. Defaults to a
  /// spinner in a card.
  final WidgetBuilder? progressBuilder;

  /// Shows action errors. Defaults to a [SnackBar].
  final ErrorMessenger? errorMessenger;

  /// The label of the default retry button.
  final String retryLabel;

  /// Builds the loading view.
  Widget buildLoading(BuildContext context) =>
      loadingBuilder?.call(context) ?? const SoftLoadingView();

  /// Builds the error view.
  Widget buildError(
    BuildContext context,
    SoftError error,
    VoidCallback? onRetry,
  ) =>
      errorBuilder?.call(context, error, onRetry) ??
      SoftErrorView(error: error, onRetry: onRetry, retryLabel: retryLabel);

  /// Builds the initial view.
  Widget buildInitial(BuildContext context) =>
      initialBuilder?.call(context) ?? const SizedBox.shrink();

  /// Builds the progress dialog content.
  Widget buildProgress(BuildContext context) =>
      progressBuilder?.call(context) ??
      const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: CircularProgressIndicator(),
          ),
        ),
      );

  /// Shows an action error.
  void showError(BuildContext context, SoftError error) {
    final messenger = errorMessenger;
    if (messenger != null) {
      messenger(context, error);
      return;
    }
    ScaffoldMessenger.maybeOf(context)
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(error.message)));
  }
}

/// Provides a [SoftCoreConfig] to the widgets below it.
///
/// ```dart
/// MaterialApp(
///   builder: (context, child) => SoftCore(
///     config: SoftCoreConfig(errorMapper: mapApiError),
///     child: child!,
///   ),
/// )
/// ```
///
/// Widgets without a [SoftCore] above them use `const SoftCoreConfig()`.
/// Wrapping inside `MaterialApp.builder` (as above) also covers dialogs and
/// pushed pages.
class SoftCore extends InheritedWidget {
  /// Provides [config] to [child].
  const SoftCore({super.key, required this.config, required super.child});

  /// The provided config.
  final SoftCoreConfig config;

  /// The nearest config, or the defaults. Rebuilds the caller when it
  /// changes; use [read] outside `build`.
  static SoftCoreConfig of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SoftCore>()?.config ??
      const SoftCoreConfig();

  /// The nearest config, or the defaults, without subscribing to changes.
  /// For callbacks such as bloc listeners.
  static SoftCoreConfig read(BuildContext context) =>
      context.getInheritedWidgetOfExactType<SoftCore>()?.config ??
      const SoftCoreConfig();

  @override
  bool updateShouldNotify(SoftCore oldWidget) => config != oldWidget.config;
}
