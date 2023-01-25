import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import '/src/core/dialogs/progress_dialog.dart';
import '/src/main_index.dart';
abstract class BaseStatelessWidget extends StatelessWidget {

  final strings = Get.context!.getStrings();
  final local = Get.locale?.languageCode ?? 'en';

  //static String routeName (){return '';}

  final CustomProgressDialog progress =
      DialogsManager.createProgress(Get.context!);

  bool isRtl() => local == 'ar';

  BaseStatelessWidget({Key? key}):  super(key: key);


  T? getArguments<T>(BuildContext context ){
    return context.getArguments();
  }

   handleErrorDialogBuilder(dynamic exception) {
    final context = Get.context! ;

    DialogsManager. showErrorDialog(context, exception);

   }

}
