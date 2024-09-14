import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import '../../di/dependency_injector.dart';
import '../../di/dialog_manager_factory.dart';
import '../../di/error_handler_factory.dart';
import '../../di/error_widget_factory.dart';
import '../../di/error_widget_factory_registry.dart';
import '../../di/softcore_injector.dart';
import '../dialogs/dialogs_manager.dart';
import '../managers/error_handler.dart';
import '../managers/error_handler_manage.dart';
import '/src/core/dialogs/progress_dialog.dart';
import '../../../main_index.dart';
abstract class MaterialStatelessWidget extends StatelessWidget {

  BuildContext? get  gContext => Get.context;
  String get  local => Get.locale?.languageCode ?? 'en';
  TextTheme get textTheme => Get.context!.textTheme;
  bool isRtl() => local == 'ar';
  ErrorHandler get errorManager => ErrorHandlerFactory.getErrorHandler();
  ErrorWidgetFactory get errorWidgetFactory => ErrorWidgetFactoryRegistry.getErrorWidgetFactory();
  DialogsManager get dialogsManager => DialogsManagerFactory.getDialogsManager();
  DependencyInjector injector () => SoftCoreInjector.injector();

  const MaterialStatelessWidget({Key? key}):   super(key: key);


  T? getArguments<T>(BuildContext context ){
    return context.getArguments();
  }




}
