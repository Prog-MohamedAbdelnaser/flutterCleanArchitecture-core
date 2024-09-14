import '../../../errorManager.dart';

abstract class ErrorHandler {
  /// Prepares and returns an `AppError` based on the exception provided.
  AppError prepareError(dynamic exception);

  /// Utility method to return a generic 'No Connection' message.
  String noConnectionMessage();

  /// Utility method to return a generic 'Undefined Error' message.
  String undefineError();

  String getLanguageCode();
}
