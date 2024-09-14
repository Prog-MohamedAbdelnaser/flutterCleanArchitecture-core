import 'package:get/get.dart';
import 'package:softcore/src/core/components/placeholder/soft_error_widget.dart';

import '../../../main_index.dart';
import '../../di/error_widget_factory_registry.dart';
import '../dialogs/dialogs_manager.dart';
import '../dialogs/progress_dialog.dart';
import 'package:get_it/get_it.dart';

import 'base/softcore_bloc_statelesswidget.dart';

abstract class MaterialBlocWidget<T, B extends BlocBase<DataState>>
    extends SoftCoreBlocStateless<T,B,DataState> {

  const MaterialBlocWidget({Key? key}) : super(key: key);

  @protected
  Widget buildWidget(BuildContext context, T state);


  showProgress() {
    progress.show();
  }

  dismissProgress() {
    progress.dismiss();
  }

  SoftcoreProgressDialog get progress => dialogsManager.createProgress(gContext!);

  @protected
  void loadInitialData(BuildContext context) {}

  @protected
  String? title(BuildContext context) {
    return null;
  }
  TextStyle titleStyle(){
    return  textTheme.titleLarge!;
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      onBuild(context);
    });
    return safeArea() ? SafeArea(
      child: buildScaffold(context)
    ):buildScaffold(context);
  }

  Widget buildScaffold(BuildContext context){
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: title(context)==null ?null:  mAppBar(context),
      body: scaffoldBody(context),
    );
  }
  Widget scaffoldBody(BuildContext context){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadInitialData(context);
    });
    return super.build(context);
  }
  bool safeArea(){
    return true ;
  }
  
  @protected
  Color backgroundColor() {
    return Colors.transparent;
  }

  @protected
  bool centerTitle() {
    return true;
  }

  @protected
  bool hasBack(BuildContext context) {
    return Navigator.canPop(context);
  }

  Widget _handleUiState(DataState state, BuildContext context) {
    if (state is DataLoading) {
      return const LoadingView();
    }
    if (state is T) {
      return buildWidget(context, state as T);
    }
    if (state is DataFailed) {
      return buildApiErrorWidget(state.error,
          onClickReload: (){
            onClickReload(context);
          });
    }
    return onBuildUnInitWidget(context);
  }

  Widget onBuildUnInitWidget(BuildContext context) {
    return const Center();
  }

  Widget buildApiErrorWidget(exception, {Function()? onClickReload}) {
    return errorWidget(
      exception: exception,
      onClickReload: onClickReload,
    );
  }

  Widget errorWidget(
      {exception, Function()? onClickReload}){
    return errorWidgetFactory.createErrorWidget(errorManager.prepareError(exception),onRetry: onClickReload,);
  }

  void handleApiErrorDialog(error, BuildContext context) {
    final errorModel = errorManager.prepareError(error);
    dialogsManager.showMessageDialog(context, errorModel.message);
  }

  void onClickReload(BuildContext context) {
    loadInitialData(context);
  }

  void onRequestSuccess(BuildContext context , successData) {}

  @override
  bool listenWhen(DataState previous, DataState current) {
    return current is DataStateFListener;
  }
  @override
  bool buildWhen(DataState previous, DataState current) {
    return current is DataStateFBuilder;
  }
  void onBuild(BuildContext context) {}

  handleErrorDialogBuilder(dynamic exception) {
    final context = Get.context!;
    dialogsManager.showMessageDialog(context, exception);
  }


  AppBar  ? mAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        title(context) ?? '',
        style: titleStyle()??context.textTheme.titleLarge,
      ),
      elevation: 0,
      centerTitle: centerTitle(),
      automaticallyImplyLeading: false,
      leading: hasBack(context)
          ? BackButton(onPressed: () {
              Navigator.pop(context);
            })
          : null,
      backgroundColor: backgroundColor(),
    );
  }

@override
  void handleStateChange(BuildContext context, DataState state) {
    _buildListener(context, state);
  }
  @override
  Widget buildStateWidget(BuildContext context, DataState state) {
    return _handleUiState(state, context);
  }

  void _buildListener(BuildContext context, dynamic state) {
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
      onRequestSuccess(context , state.data);
    }
  }

}
