import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/src/core/dialogs/progress_dialog.dart';
import '../../main_index.dart';


class DialogsManager {
  static CustomProgressDialog createProgress(BuildContext context) {
    return ProgressDialog.createProgress(context,);
  }

  static showErrorDialog(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            context.getStrings().ok_button,
            style: kTextBold.copyWith(color: kPrimary, fontSize: 14),
          ),
        )
      ],
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                child: Image.asset(
                  'images/error.gif',
                  height: 60,
                ),
              ),
              Text(
                text,
                style: kTextMedium.copyWith(color: kFontDarkColor, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    });
  }

  static showAlertDialog(BuildContext context, Widget content) {
    AlertDialog alert = AlertDialog(
      content: Container(
        child:content,
      ),
    );

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    });
  }

  static onBackPress(BuildContext context) {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
