import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softcore/basebloc.dart';

import '../../../softMaterials.dart';

class SoftBlocConsumer<S> extends MaterialStatelessWidget {
  final B bloc;
  final Widget Function(BuildContext context, S state) builder;
  final void Function(BuildContext context, S state)? listener;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, String message)? errorBuilder;
  final Function()? onClickReload ;
  final Function(dynamic data)? onRequestSuccess ;
  const SoftBlocConsumer({
    Key? key,
    required this.bloc,
    required this.builder,
    this.listener,
    this.loadingBuilder,
    this.errorBuilder,
    this.onClickReload,this.onRequestSuccess
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      bloc: bloc,
      listenWhen: (previous, current) {
        return current is DataStateFListener;
      },
      buildWhen: (previous, current) {
        return current is DataStateFBuilder;
      },
      listener: listener ?? buildListener(context, state),
      builder: (context, state) {
        if (state is DataLoading ) {
          return loadingBuilder != null ?loadingBuilder!(context) :const LoadingView(height: 150,);
        } else if (state is DataFailed ) {
          return errorBuilder != null ?errorBuilder!(context, (state).error):
          placeHolderWidget(exception: state.error,onClickReload: onClickReload);
        } else {
          return builder(context, state);
        }
      },
    );
  }


  void buildListener(BuildContext context, dynamic state) {
    if (state is LoadingStateListener) {
      showProgress();
    } else {
      dismissProgress();
    }

    if (state is FailureStateListener) {
      handleApiErrorDialog(state.error, context);
    }

    if (state is SuccessStateListener) {
      onRequestSuccess(context , state.data);
    }
  }

  ErrorPlaceHolderWidget placeHolderWidget(
      {exception, Function()? onClickReload}){
    return ErrorPlaceHolderWidget(error: errorManager(publicContext!).prepareError(exception),onRetryButton: onClickReload,height: 150,);
  }
}
