import 'default_error_widget_factory.dart';
import 'states_widgets_factory.dart';

class StatesWidgetsFactoryRegistry {
  static StatesWidgetFactory? _customFactory;

  // Get the current error widget factory (custom or default)
  static StatesWidgetFactory getStatesWidgetFactory() {
    return _customFactory ?? DefaultStatesWidgetFactory();
  }

  // Allow the developer to provide a custom error widget factory
  static void setCustomErrorWidgetFactory(StatesWidgetFactory factory) {
    _customFactory = factory;
  }

  // Reset to the default error widget factory
  static void resetToDefault() {
    _customFactory = null;
  }
}
