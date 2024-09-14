import '../../softMaterials.dart';
import '../core/dialogs/dialogs_manager.dart';

class DialogsManagerFactory {
  static DialogsManager _defaultDialogsManager = DefaultDialogsManager();

  static DialogsManager getDialogsManager() {
    return _defaultDialogsManager;
  }

  static void setCustomDialogsManager(DialogsManager dialogsManager) {
    _defaultDialogsManager = dialogsManager;
  }
}
