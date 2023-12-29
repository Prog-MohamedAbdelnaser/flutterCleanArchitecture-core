import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import '../managers/error_handler_manage.dart';
import '/src/core/dialogs/progress_dialog.dart';
import '/src/main_index.dart';
abstract class BaseStatelessWidget extends StatelessWidget {
  final gContext = Get.context;
  final strings = Get.context!.getStrings();
  final local = Get.locale?.languageCode ?? 'en';
  final textTheme = Get.context!.textTheme;

  //static String routeName (){return '';}

  final CustomProgressDialog progress =
      DialogsManager.createProgress(Get.context!);

  bool isRtl() => local == 'ar';

  BaseStatelessWidget({Key? key}):  super(key: key);


  T? getArguments<T>(BuildContext context ){
    return context.getArguments();
  }

  ErrorHandlerManager errorManager(BuildContext context) {
    return ErrorHandlerManager(context);
  }



}
