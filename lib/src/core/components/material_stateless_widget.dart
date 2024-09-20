import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import '../managers/error_handler_manage.dart';
import '/src/core/dialogs/progress_dialog.dart';
import '../../../main_index.dart';
import 'base/softcore_context/softcore_base_context.dart';
import 'base/softcore_context/softcore_context.dart';
abstract class MaterialStatelessWidget extends StatelessWidget {

  BuildContext? get  publicContext => Get.context;
  String get  local => Get.locale?.languageCode ?? 'en';
  TextTheme get textTheme => Get.context!.textTheme;
  bool isRtl() => local == 'ar';

  const MaterialStatelessWidget({Key? key}):  super(key: key);


  T? getArguments<T>(BuildContext context ){
    return context.getArguments();
  }

  ErrorHandlerManager errorManager(BuildContext context) {
    return ErrorHandlerManager(context);
  }

  @override
  Widget build(BuildContext context) {
    SoftCoreContext softContext =  BaseCoreContext(context, dialogsManager: DialogsManager(), progress: DialogsManager().createProgress(context));
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
