import 'package:flutter/material.dart';
import '../../../../softMaterials.dart';
import '../../bloc/data_state.dart';

class StreamStateWidget<T> extends SoftCoreStatelessWidget {
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context)? preLoadingBuilder;
  final Widget Function(BuildContext context, dynamic error)? errorBuilder;
  final StreamState<T?> stream;
  final Function()? onReload;

  StreamStateWidget({
    super.key,
    required this.builder,
    this.preLoadingBuilder,
    this.errorBuilder,
    required this.stream,
    this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T?>(
        stream: stream.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const SizedBox.shrink();
          }
          if (snapshot.data != null) {
            return builder(context, snapshot.data as T);
          } else if (snapshot.error != null) {
            return errorBuilder!=null ? errorBuilder!(context,snapshot.error):  handleApiErrorPlaceHolder(context, snapshot.error, onClickReload: onReload);
          }
          return preLoadingBuilder !=null ? preLoadingBuilder!(context):   statesWidgetsFactory.createLoadingViewWidget(height: 150,);
        });
  }


  Widget handleApiErrorPlaceHolder(BuildContext context, error,
      {Function()? onClickReload}) {
    final errorModel = errorManager.prepareError(error);
    return statesWidgetsFactory.createErrorWidget(
      errorModel,
      onRetry: onReload,
      height: 250,
    );
  }
}