import 'package:flutter/cupertino.dart';
import 'package:softcore/src/core/dialogs/progress_dialog.dart';

abstract class DialogsManager {
  SoftcoreProgressDialog createProgress(BuildContext context);

  void showSuccessfullyDialog(BuildContext context, {required Function() onDismiss, String? message});

  void showCustomDialog(BuildContext context, Widget content, {Color? barrierColor});

  void showMessageDialog(BuildContext context, String text, {
    String? iconPath,
    bool cancelable = true,
    Function()? onClick,
    Function()? onDismiss,
  });

  void showErrorDialog(BuildContext context, String text, {
    String? iconPath,
    bool cancelable = true,
    Function()? onClick,
    Function()? onDismiss,
  });
  void showWarningDialog(BuildContext context, String text, {
    String? iconPath,
    bool cancelable = true,
    Function()? onClick,
    Function()? onDismiss,
  });


  void showConfirmationDialog(BuildContext context, {
    required String message,
    required Function onConfirm
  });

  void onBackPress(BuildContext context);
}
