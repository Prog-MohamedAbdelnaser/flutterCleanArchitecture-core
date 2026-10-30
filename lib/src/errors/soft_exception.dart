/// An exception with a message that is safe to show to the user.
///
/// The default error mapper shows [message] as is. Throw it (or subclass
/// it) from repositories when you already know what to tell the user.
class SoftException implements Exception {
  /// Creates an exception with a user-facing [message].
  const SoftException(this.message, {this.code, this.cause});

  /// The user-facing message.
  final String message;

  /// An optional machine-readable code, e.g. from your API.
  final String? code;

  /// The underlying error, if any.
  final Object? cause;

  /// The message for [languageCode]. Plain exceptions have one message.
  String messageFor(String? languageCode) => message;

  @override
  String toString() => message;
}

/// A [SoftException] with a message per language.
///
/// ```dart
/// throw LocalizedException({'en': 'Out of stock', 'ar': 'نفدت الكمية'});
/// ```
///
/// The default error mapper picks the message for the app's current locale,
/// falling back to [fallbackLanguage], then to any message.
class LocalizedException extends SoftException {
  /// Creates an exception from [messages], keyed by language code.
  LocalizedException(
    this.messages, {
    this.fallbackLanguage = 'en',
    super.code,
    super.cause,
  })  : assert(messages.isNotEmpty, 'messages must not be empty'),
        super(messages[fallbackLanguage] ?? messages.values.first);

  /// Messages keyed by language code, e.g. `{'en': ..., 'ar': ...}`.
  final Map<String, String> messages;

  /// The language used when the current one has no message.
  final String fallbackLanguage;

  @override
  String messageFor(String? languageCode) => messages[languageCode] ?? message;
}
