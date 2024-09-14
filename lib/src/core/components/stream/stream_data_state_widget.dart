import 'package:flutter/material.dart';
import '../../../../softMaterials.dart';
import '../../bloc/data_state.dart';


class StreamDataStateWidget<T> extends MaterialStatelessWidget {
  final Widget Function(BuildContext context, T data) ?builder;
  final Widget Function(BuildContext context, DataState<T> state) ? stateBuilder;
  final Widget Function(BuildContext context, Widget child)? frameBuilder;
  final StreamDataState<T> stream;
  final DataState<T> ? initialData ;
  final Function()? onReload;
  final double ? placeHolderHeight ;
  StreamDataStateWidget({
    super.key,
     this.builder,
    this.frameBuilder,
    required this.stream,
    this.stateBuilder,
    this.initialData,
    this.onReload,
    this.placeHolderHeight,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataState<T>>(
        stream: stream.stream,
        initialData:initialData ,
        builder: (context, snapshot) {
          print('stateBuilderstateBuilder ${snapshot.data}');
          return  frameBuilder!=null ? frameBuilder!(context , _build(context,snapshot)) : _build(context,snapshot);
        });
  }

  Widget handleDataState(DataState state, BuildContext context) {

    if (state is DataSuccess<T>) {
      return builder!=null ?builder!(context, state.data):const SizedBox.shrink();
    }
    if (state is DataLoading) {
      return  LoadingView(height: placeHolderHeight,);
    }

    if (state is DataFailed) {
      return handleApiErrorPlaceHolder(context , state.error, onClickReload: onReload);

    }
    return const Center();
  }

  Widget handleApiErrorPlaceHolder(BuildContext context, error,
      {Function()? onClickReload}) {
    final errorModel = errorManager.prepareError(error);
    return errorWidgetFactory.createErrorWidget(
      errorModel,
      onRetry: onReload,
      height: placeHolderHeight??250,
    );
  }

  Widget _build(BuildContext context, AsyncSnapshot<DataState<T>> snapshot) {
    if (snapshot.connectionState != ConnectionState.active) {
      return const SizedBox.shrink();
    }
    if (snapshot.data is DataState) {
      return stateBuilder !=null ? stateBuilder!(context,snapshot.data as DataState<T>):
       handleDataState(snapshot.data as DataState, context);
    }
    if (snapshot.error != null) {
      return handleApiErrorPlaceHolder(context,snapshot.error,
          onClickReload: onReload);
    }
    return const SizedBox.shrink();
  }
}

