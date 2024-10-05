import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import '../../di/dependency_injector.dart';
import '../../di/dialog_manager_factory.dart';
import '../../di/error_handler_factory.dart';
import '../../di/states_widgets_factory.dart';
import '../../di/states_widget_factory_registry.dart';
import '../../di/soft_core_dependencies_factories.dart';
import '../../di/softcore_injector.dart';
import '../dialogs/dialogs_manager.dart';
import '../managers/error_handler.dart';
import '../managers/error_handler_manage.dart';
import '/src/core/dialogs/progress_dialog.dart';
import '../../../main_index.dart';
import 'base/softcore_context/softcore_base_context.dart';
import 'base/softcore_context/softcore_context.dart';
abstract class SoftStatelessWidget extends StatelessWidget {

  BuildContext? get  publicContext => Get.context;
  String get  local => Get.locale?.languageCode ?? 'en';
  TextTheme get textTheme => Get.context!.textTheme;
  bool isRtl() => local == 'ar';

  SoftCoreDependenciesFactories get softCoreDependenciesFactories => SoftCoreDependenciesFactories();
  ErrorHandler get errorManager => softCoreDependenciesFactories.errorManager;
  StatesWidgetFactory get statesWidgetsFactory => softCoreDependenciesFactories.statesWidgetsFactory;
  DialogsManager get dialogsManager => softCoreDependenciesFactories.dialogsManager;
  DependencyInjector injector () => SoftCoreInjector.injector();

  const  SoftStatelessWidget({Key? key}):   super(key: key);


  T? getArguments<T>(BuildContext context ){
    return context.getArguments();
  }




  @override
  Widget build(BuildContext context) {
    SoftCoreContext softContext =  BaseCoreContext(context, dialogsManager: dialogsManager, progress: dialogsManager.createProgress(context));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      onBuild(softContext);
    });
    return softBuild(softContext);
  }
  Widget softBuild(SoftCoreContext context){
    return const SizedBox.shrink();
  }
  void onBuild(SoftCoreContext context) {}
}
