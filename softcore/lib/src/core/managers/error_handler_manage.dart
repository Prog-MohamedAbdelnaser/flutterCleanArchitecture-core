

import '../../main_index.dart';
import 'app_error.dart';

abstract class ErrorHandlerManager {
  final BuildContext context;

  ErrorHandlerManager(this.context);

  AppLocalizations strings() => context.getStrings();

  AppError appErrorFromException(dynamic exception);

  bool unAuthorizedException(dynamic exception);
}
