import 'package:flutter/src/widgets/framework.dart';

import 'package:softcore/src/core/components/base/softcore_context/softcore_context.dart';

import '../../../main_index.dart';
import '../../../softMaterials.dart';
import 'soft_lifecycle_widget.dart';

abstract class SoftLifecycleBlocWidget<T, B extends BlocBase<DataState>>
    extends SoftLifecycleWidget {
  @override
  Widget build(SoftCoreContext context) {
    return consumerBuilder();
  }

  Widget consumerBuilder() {
    return _SoftLifecycleBlocWidget<T, B>(
      builder: (SoftCoreContext context, state) {
        return buildWidget(context, state);
      },
    );
  }

  Widget buildWidget(SoftCoreContext context, T state);
}

class _SoftLifecycleBlocWidget<T, B extends BlocBase<DataState>>
    extends SoftBlocWidget<T, B> {
  final Widget Function(SoftCoreContext context, T data) builder;

  _SoftLifecycleBlocWidget({required this.builder});

  @override
  Widget buildWidget(SoftCoreContext context, T state) {
    return builder(context, state);
  }
}
