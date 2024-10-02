import 'package:flutter/material.dart';
import 'package:softcore/errorManager.dart';

import '../../main_index.dart';
import '../core/components/stateswidgets/soft_error_widget.dart';
import '../core/components/stateswidgets/soft_loading_widget.dart';

abstract class StatesWidgetFactory {
  SoftErrorWidget createErrorWidget(AppError error, {void Function()? onRetry,double ? height});
  SoftLoadingWidget createLoadingViewWidget({double ? height});
}
