import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/src/core/dialogs/progress_dialog.dart';
import '../../main_index.dart';
export 'dialogs_manager.dart';
 class DialogsManager {
  static CustomProgressDialog createProgress(BuildContext context) {
    return ProgressDialog.createProgress(context,);
  }
   showSuccessfullyAnimDialog(BuildContext context, {required Function() onDismiss, String? message}){
     showMessageDialog(context,message??'',onDismiss:onDismiss);
   }

   showCustomDialog(BuildContext context, Widget content,
      {Color? barrierColor}) {
    showDialog(
        barrierColor: barrierColor ??context.theme.primaryColor.withOpacity(0.7),
        barrierDismissible: false,
        context: context,
        useSafeArea: true,
        builder: (_) => content);
  }

   showMessageDialog(
      BuildContext context,
      String text, {
        String? iconPath,
        bool cancelable = true,
        String? buttonName,
        Function()? onClick,
        Function()? onDismiss,
      }) {
    AlertDialog alert = AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            if (onClick != null) {
              onClick();
            } else {
              Navigator.pop(context);
            }
          },
          child: Text(buttonName ??'ok',
              style: context.textTheme.titleMedium?.copyWith(color: context.theme.primaryColor)),
        )
      ],
      content: WillPopScope(
        onWillPop: () async {
          return cancelable == true;
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconPath != null
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: iconPath.endsWith('svg')
                    ? SvgPicture.asset(
                  iconPath,
                  height: 50,
                )
                    : Image.asset(
                  iconPath,
                  height: 50,
                ),
              )
                  : SizedBox(
                height: 60,
              ),
              Text(
                text,
                style: context.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        barrierDismissible: cancelable,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    });
  }

   showConfirmationDialog(BuildContext context,
      {required String message,
        String? buttonName,
        String? cancelText,
        required Function onConfirm}) {
    AlertDialog alert = AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(
            buttonName ?? 'ok',
            style: context.textTheme.bodyMedium?.copyWith(color: context.theme.primaryColor, fontSize: 14),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            cancelText??'Cancel',
            style: context.textTheme.bodyMedium?.copyWith(color: context.theme.unselectedWidgetColor),
          ),
        )
      ],
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              message,
              style: context.textTheme.bodyMedium?.copyWith(color: context.theme.primaryColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


   static showAlertDialog(BuildContext context, Widget content) {
    AlertDialog alert = AlertDialog(
      content: Container(
        child:content,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    });
  }

   onBackPress(BuildContext context) {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
