import 'package:softcore/errorManager.dart';

import '../../main_index.dart';
import '../core/components/stateswidgets/default_error_widget.dart';
import '../core/components/stateswidgets/soft_error_widget.dart';
import '../core/components/stateswidgets/soft_loading_widget.dart';
import 'states_widgets_factory.dart';

class DefaultStatesWidgetFactory implements StatesWidgetFactory {
  @override
  SoftErrorWidget createErrorWidget(AppError error, {void Function()? onRetry, double? height}) {
    return DefaultErrorWidget(
      error: error,
      onRetry: onRetry,height: height,
    );
  }

  @override
  SoftLoadingWidget createLoadingViewWidget({double? height}) {
    return SoftCoreDefaultLoadingView();
  }

}
