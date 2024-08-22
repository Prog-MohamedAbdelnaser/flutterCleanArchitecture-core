import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import '../managers/error_handler_manage.dart';
import '/src/core/dialogs/progress_dialog.dart';
import '../../../main_index.dart';
abstract class MaterialStatelessWidget extends StatelessWidget {

  BuildContext? get  gContext => Get.context;
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

}
