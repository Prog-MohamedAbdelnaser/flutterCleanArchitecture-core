import 'package:softcore/errorManager.dart';

import '../../main_index.dart';
import 'error_widget_factory.dart';

class DefaultErrorWidgetFactory implements ErrorWidgetFactory {
  @override
  Widget createErrorWidget(AppError error, {void Function()? onRetry, double? height}) {
    return DefaultErrorWidget(
      error: error,
      onRetry: onRetry,height: height,
    );
  }

}
