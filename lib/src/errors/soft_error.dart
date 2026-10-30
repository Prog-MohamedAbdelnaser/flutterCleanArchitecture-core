import 'package:flutter/widgets.dart';

import 'soft_exception.dart';

/// An error ready to show: what the error views and messages display.
@immutable
class SoftError {
  /// Creates a displayable error.
  const SoftError({
    required this.message,
    this.title,
    this.code,
    this.cause,
  });

  /// The text shown to the user.
  final String message;

  /// An optional heading.
  final String? title;

  /// An optional machine-readable code.
  final String? code;

  /// The original error.
  final Object? cause;

  @override
  String toString() => 'SoftError($message${code == null ? '' : ', $code'})';
}

/// Turns any thrown error into a [SoftError].
///
/// Plug in your own to translate network or API errors:
///
/// ```dart
/// SoftError mapError(BuildContext context, Object error) {
///   if (error is DioException) return SoftError(message: 'No connection');
///   return defaultErrorMapper(context, error);
/// }
/// ```
typedef ErrorMapper = SoftError Function(BuildContext context, Object error);

/// The built-in [ErrorMapper].
///
/// * [SoftException]: its message, localized for the current locale.
/// * [String]: the string itself.
/// * Anything else: its `toString()`, without a leading `Exception: `.
SoftError defaultErrorMapper(BuildContext context, Object error) {
  if (error is SoftError) return error;
  if (error is SoftException) {
    final language = Localizations.maybeLocaleOf(context)?.languageCode;
    return SoftError(
      message: error.messageFor(language),
      code: error.code,
      cause: error,
    );
  }
  if (error is String) return SoftError(message: error, cause: error);
  var message = error.toString();
  const prefix = 'Exception: ';
  if (message.startsWith(prefix)) message = message.substring(prefix.length);
  return SoftError(message: message, cause: error);
}
