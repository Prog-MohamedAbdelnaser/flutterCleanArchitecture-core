import 'package:flutter/material.dart';

import '../errors/soft_error.dart';

/// The default loading view: a centered spinner.
class SoftLoadingView extends StatelessWidget {
  /// Creates the loading view, optionally with a fixed [height].
  const SoftLoadingView({super.key, this.height});

  /// A fixed height, useful inside lists and scroll views.
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

/// The default error view: the message and a retry button.
class SoftErrorView extends StatelessWidget {
  /// Creates the error view.
  const SoftErrorView({
    super.key,
    required this.error,
    this.onRetry,
    this.retryLabel = 'Retry',
  });

  /// The error to show.
  final SoftError error;

  /// Called by the retry button; no button when `null`.
  final VoidCallback? onRetry;

  /// The retry button's label.
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 12),
            if (error.title != null) ...[
              Text(error.title!, style: theme.textTheme.titleMedium),
              const SizedBox(height: 4),
            ],
            Text(
              error.message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              FilledButton.tonal(onPressed: onRetry, child: Text(retryLabel)),
            ],
          ],
        ),
      ),
    );
  }
}
