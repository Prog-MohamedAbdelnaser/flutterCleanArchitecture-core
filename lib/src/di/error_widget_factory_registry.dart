import 'default_error_widget_factory.dart';
import 'error_widget_factory.dart';

class ErrorWidgetFactoryRegistry {
  static ErrorWidgetFactory? _customFactory;

  // Get the current error widget factory (custom or default)
  static ErrorWidgetFactory getErrorWidgetFactory() {
    return _customFactory ?? DefaultErrorWidgetFactory();
  }

  // Allow the developer to provide a custom error widget factory
  static void setCustomErrorWidgetFactory(ErrorWidgetFactory factory) {
    _customFactory = factory;
  }

  // Reset to the default error widget factory
  static void resetToDefault() {
    _customFactory = null;
  }
}
