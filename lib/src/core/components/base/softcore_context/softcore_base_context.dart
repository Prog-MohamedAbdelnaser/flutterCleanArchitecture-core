import 'package:flutter/cupertino.dart';
import '../../../../../softMaterials.dart';
import '../../../dialogs/dialogs_manager.dart';
import '../../../dialogs/progress_dialog.dart';

class  BaseCoreContext extends SoftCoreContext {
  // Managers for dialogs and progress
   final DialogsManager dialogsManager;
   final SoftcoreProgressDialog progress;

  // Initialize context, dialog manager, and progress dialog
  const BaseCoreContext(BuildContext context ,
      { required this.dialogsManager, required this.progress}) : super(context);
  // Example of dialog management
  @override
  void showError(String message) {
    dialogsManager.showMessageDialog(context,message);
  }

  // Example of progress dialog management
  @override
  void showProgress() {
    progress.show();
  }

  @override
  void hideProgress() {
    progress.dismiss();
  }

  @override
  DialogsManager dialogManager() {
   return dialogsManager;
  }
}