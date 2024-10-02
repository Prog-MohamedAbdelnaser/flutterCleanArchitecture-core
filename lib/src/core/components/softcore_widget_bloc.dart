import 'package:get/get.dart';
import '../../../main_index.dart';
import '../../../softMaterials.dart';
import '../../di/states_widget_factory_registry.dart';
import '../dialogs/dialogs_manager.dart';
import '../dialogs/progress_dialog.dart';
import 'package:get_it/get_it.dart';

import 'base/softcore_bloc_statelesswidget.dart';

abstract class MaterialBlocWidget<T, B extends BlocBase<DataState>>
    extends SoftCoreBlocStateless<T,B,DataState> {
  late SoftCoreContext softContext ;


  B get bloc => GetIt.instance.get<B>();


   MaterialBlocWidget({Key? key}) : super(key: key);

  @protected
  Widget buildWidget(BuildContext context, T state);


  showProgress() {
    softContext.showProgress();
  }

  dismissProgress() {
    softContext.hideProgress();
  }

  @protected
  void loadInitialData(BuildContext context) {}

  @protected
  String? title(BuildContext context) {
    return null;
  }
  TextStyle titleStyle(){
    return  publicContext!.textTheme.titleLarge!;
  }


   @override
  Widget softBuild(SoftCoreContext context) {
     this.softContext =  context ;
     return safeArea() ? SafeArea(
         child: buildScaffold(context)
     ):buildScaffold(context);
  }


  Widget buildScaffold(SoftCoreContext context){
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: title(context.context)==null ?null:  mAppBar(context.context),
      body: scaffoldBody(context),
    );
  }
  Widget scaffoldBody(SoftCoreContext context){
    return super.build(context.context);
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

  Widget handleUiState(DataState state, BuildContext context) {
    print('handleUiState $state => ${state is T}');
    if (state is DataLoading) {
      return statesWidgetsFactory.createLoadingViewWidget();
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
    return statesWidgetsFactory.createErrorWidget(errorManager.prepareError(exception),onRetry: onClickReload,);
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
    return handleUiState(state, context);
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
