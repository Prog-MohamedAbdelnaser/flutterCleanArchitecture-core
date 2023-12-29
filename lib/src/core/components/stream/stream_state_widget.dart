import 'package:flutter/material.dart';

import '../../../core/components/common/common_state.dart';
import '../../../softMaterials.dart';
import '../../resources/data_state.dart';

class StreamStateWidget<T> extends BaseStatelessWidget {
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context, Widget child)? preLoadingBuilder;
  final Widget Function(BuildContext context, dynamic error)? errorBuilder;
  final StreamState<T> stream;
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
    return StreamBuilder<T>(
        stream: stream.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const SizedBox.shrink();
          }
          if (snapshot.data != null) {
            return builder(context, snapshot.data as T);
          } else if (snapshot.error != null) {
            return handleApiErrorPlaceHolder(context, snapshot.error, onClickReload: onReload);
          }
          return const LoadingView(height: 150,);
        });
  }


  Widget handleApiErrorPlaceHolder(BuildContext context, error,
      {Function()? onClickReload}) {
    final errorModel = errorManager(context).prepareError(error);
    return ErrorPlaceHolderWidget(
      color: Colors.transparent,
      onRetryButton: onReload,
      height: 250,
      error: errorModel,
    );
  }
}

class StreamDataStateWidget<T> extends BaseStatelessWidget {
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context, Widget child)? preLoadingBuilder;
  final Widget Function(BuildContext context, Widget child, dynamic error)?
      errorBuilder;
  final StreamState<DataState<T>> stream;
  final Function()? onReload;

  StreamDataStateWidget({
    super.key,
    required this.builder,
    this.preLoadingBuilder,
    this.errorBuilder,
    required this.stream,
    this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DataState<T>>(
        stream: stream.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const SizedBox.shrink();
          }
          if (snapshot.data is DataState) {
            return handleDataState(snapshot.data as DataState, context);
          }
          if (snapshot.error != null) {
            return handleApiErrorPlaceHolder(context , snapshot.error,
                onClickReload: onReload);
          }
          return const LoadingView(
            height: 150,
          );
        });
  }

  Widget handleDataState(DataState state, BuildContext context) {
    if (state is DataLoading) {
      return preLoadingBuilder == null
          ? const LoadingView()
          : preLoadingBuilder!(context, const LoadingView());
    }
    if (state is DataSuccess<T>) {
      return builder(context, state.data!);
    }
    if (state is DataFailed) {
      return preLoadingBuilder == null && errorBuilder == null
          ? handleApiErrorPlaceHolder(context , state.error, onClickReload: onReload)
          : errorBuilder != null
              ? errorBuilder!(
                  context, handleApiErrorPlaceHolder(context , state.error), state.error)
              : preLoadingBuilder!(
                  context,
                  handleApiErrorPlaceHolder(context , state.error,
                      onClickReload: onReload));
    }
    return const Center();
  }

  Widget handleApiErrorPlaceHolder(BuildContext context, error,
      {Function()? onClickReload}) {
    final errorModel = errorManager(context).prepareError(error);
    return ErrorPlaceHolderWidget(
      color: Colors.transparent,
      onRetryButton: onReload,
      height: 250,
      error: errorModel,
    );
  }
}
