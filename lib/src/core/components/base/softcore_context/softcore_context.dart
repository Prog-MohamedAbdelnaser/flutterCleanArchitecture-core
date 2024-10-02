import 'package:softcore/main_index.dart';
import 'package:softcore/src/core/dialogs/progress_dialog.dart';

import '../../../dialogs/dialogs_manager.dart';

abstract class SoftCoreContext {
   // Holds the build context
    final BuildContext context;

   // Constructor to ensure context is passed
   const SoftCoreContext(this.context);

   // Abstract methods to enforce context-based management
   ThemeData get themeData => Theme.of(context);
   TextTheme get textTheme => Theme.of(context).textTheme;

   // Abstract error or dialog management, to be extended by child classes
   void showError(String message);
   void showProgress();
   void hideProgress();
   DialogsManager dialogManager();
}
