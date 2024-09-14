

import '../../errorManager.dart';
import '../core/managers/error_handler.dart';

class ErrorHandlerFactory {
  static ErrorHandler? _customHandler;

  // Get the current error handler (custom or default)
  static ErrorHandler getErrorHandler() {
    return _customHandler ?? DefaultErrorHandler.instance;
  }

  // Allow the developer to provide a custom error handler
  static void setCustomErrorHandler(ErrorHandler handler) {
    _customHandler = handler;
  }

  // Reset to the default error handler
  static void resetToDefault() {
    _customHandler = null;
  }
}
