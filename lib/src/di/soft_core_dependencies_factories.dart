import 'package:softcore/softMaterials.dart';

import '../core/dialogs/dialogs_manager.dart';
import '../core/managers/error_handler.dart';
import 'dialog_manager_factory.dart';

class SoftCoreDependenciesFactories{
  const SoftCoreDependenciesFactories();
   ErrorHandler get errorManager => ErrorHandlerFactory.getErrorHandler();
  StatesWidgetFactory get statesWidgetsFactory => StatesWidgetsFactoryRegistry.getStatesWidgetFactory();
   DialogsManager get dialogsManager => DialogsManagerFactory.getDialogsManager();
   DependencyInjector injector () => SoftCoreInjector.injector();
}