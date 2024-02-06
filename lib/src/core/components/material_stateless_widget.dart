import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import '../managers/error_handler_manage.dart';
import '/src/core/dialogs/progress_dialog.dart';
import '../../../main_index.dart';
abstract class MaterialStatelessWidget extends StatelessWidget {
  final gContext = Get.context;

  final local = Get.locale?.languageCode ?? 'en';
  final textTheme = Get.context!.textTheme;

  //static String routeName (){return '';}
  
  final CustomProgressDialog progress =
      DialogsManager.createProgress(Get.context!);

  bool isRtl() => local == 'ar';

  MaterialStatelessWidget({Key? key}):  super(key: key);


  T? getArguments<T>(BuildContext context ){
    return context.getArguments();
  }

  ErrorHandlerManager errorManager(BuildContext context) {
    return ErrorHandlerManager(context);
  }




}
