import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../main_index.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class BaseBlocWidget<T, B extends BlocBase<DataState>>
    extends BaseStatelessWidget {
  late BuildContext context;
  late B bloc = getBloc();

  B getBloc() {
    if (initBloc(context) != null) {
      return initBloc(context)!;
    } else {
      return GetIt.instance.get<B>();
    }
  }
  B? initBloc(BuildContext context) {
    return null;
  }
  BaseBlocWidget({Key? key}) : super(key: key);

  @protected
  Widget buildWidget(BuildContext context, T state);

  void buildListener(BuildContext context, dynamic state) {
    if (state is LoadingStateListener) {
      showProgress();
    } else {
      dismissProgress();
    }

    if (state is FailureStateListener) {
      dismissProgress();
      handleApiErrorDialog(state.error, context);
    }

    if (state is SuccessStateListener) {
      dismissProgress();
      onRequestSuccess(state.data);
    }
  }

  showProgress() {
    progress.show();
  }

  dismissProgress() {
    progress.dismiss();
  }

  @protected
  void loadInitialData(BuildContext context) {}

  @protected
  String? title(BuildContext context) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: buildConsumer(context),
    );
  }

  Widget handleUiState(DataState state, BuildContext context) {
    if (state is DataLoading) {
      return LoadingView();
    }
    if (state is T) {
      return buildWidget(context, state as T);
    }
    if (state is DataFailed) {
      return handleApiErrorPlaceHolder(state.error,
          onClickReload: onClickReload);
    }
    return onBuildUnInitWidget(context);
  }

  Widget onBuildUnInitWidget(BuildContext context) {
    return const Center();
  }

  Widget handleApiErrorPlaceHolder(exception, {Function()? onClickReload}) {
    return placeHolderWidget(
      exception: exception,
      onClickReload: onClickReload,
    );
  }
  ErrorPlaceHolderWidget placeHolderWidget( {exception,Function()? onClickReload});

  void handleApiError(error,
      {required Function(String message, String code) onHandleMessage}) {
    final errorApi = Get.context!.handleApiError(exception: error);
    onHandleMessage(errorApi.code, "0");
  }

  void handleApiErrorDialog(error, BuildContext context) {
    dialogsManager(context).showErrorDialog(
        context, context.handleApiErrorMessage(exception: error));
  }

  onClickReload() {}

  void onRequestSuccess(successData) {}


  BlocConsumer buildConsumer(BuildContext context) {
    this.context = context;
    final consumer = BlocConsumer<B, DataState>(
        bloc: bloc,
        listenWhen: (state, current) {
          return current is DataStateFListener;
        },
        buildWhen: (state, current) {
          return current is DataStateFBuilder;
        },
        builder: (context, state) => handleUiState(state, context),
        listener: (context, state) => buildListener(context, state));
    loadInitialData(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      onBuild(context);
    });
    return consumer;
  }
  void onBuild(BuildContext context) {}

  handleErrorDialogBuilder(dynamic exception) {
    final context = Get.context! ;
    dialogsManager(context). showErrorDialog(context, exception);
  }

  DialogsManager dialogsManager (BuildContext context);


}