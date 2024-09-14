import 'package:flutter/material.dart';
import 'package:softcore/errorManager.dart';

import '../../main_index.dart';

abstract class ErrorWidgetFactory {
  Widget createErrorWidget(AppError error, {void Function()? onRetry,double ? height});
}
