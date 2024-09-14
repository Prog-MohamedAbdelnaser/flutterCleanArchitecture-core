import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../main_index.dart';
import '../dialogs/dialogs_manager.dart';
import '/src/core/dialogs/progress_dialog.dart';
export 'default_dialogs_manager.dart';
class DefaultDialogsManager implements DialogsManager {
  @override
  SoftcoreProgressDialog createProgress(BuildContext context) {
    // Implement the default progress dialog creation here
    return ProgressDialog.createProgress(context);
  }

  @override
  void showSuccessfullyDialog(BuildContext context, {required Function() onDismiss, String? message}) {
    showMessageDialog(context, message ?? 'Success', onClick: onDismiss);
  }

  @override
  void showCustomDialog(BuildContext context, Widget content, {Color? barrierColor}) {
    showDialog(
      context: context,
      barrierColor: barrierColor ?? Colors.black.withOpacity(0.5),
      builder: (BuildContext context) => content,
    );
  }

  @override
  void showMessageDialog(BuildContext context, String text, {
    String? iconPath,
    bool cancelable = true,
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
          child: Text('OK', style: Theme.of(context).textTheme.button),
        )
      ],
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );

    showDialog(
      barrierDismissible: cancelable,
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  @override
  void showErrorDialog(BuildContext context, String text, {
    String? iconPath,
    bool cancelable = true,
    Function()? onClick,
    Function()? onDismiss,
  }) {
    showMessageDialog(
      context,
      text,
      iconPath: iconPath,
      cancelable: cancelable,
      onClick: onClick,
      onDismiss: onDismiss,
    );
  }

  @override
  void showWarningDialog(BuildContext context, String text, {
    String? iconPath,
    bool cancelable = true,
    Function()? onClick,
    Function()? onDismiss,
  }) {
    showMessageDialog(
      context,
      text,
      iconPath: iconPath,
      cancelable: cancelable,
      onClick: onClick,
      onDismiss: onDismiss,
    );
  }

  @override
  void showConfirmationDialog(BuildContext context, {
    required String message,
    required Function onConfirm
  }) {
    AlertDialog alert = AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text('Confirm', style: Theme.of(context).textTheme.button),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel', style: Theme.of(context).textTheme.button),
        ),
      ],
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  @override
  void onBackPress(BuildContext context) {
    Navigator.of(context).pop();
  }
}