import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../main_index.dart';
import '../../../softMaterials.dart';

abstract class MaterialBlocWidget<T, B extends BlocBase<DataState>>
    extends MaterialStatelessWidget {
   final B  bloc ;
   late SoftCoreContext softContext ;

  MaterialBlocWidget({Key? key})
      :bloc= GetIt.instance.get<B>()
  ,  super(key: key);

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
      handleApiErrorDialog(state.error, publicContext!);
    }

    if (state is SuccessStateListener) {
      dismissProgress();
      onRequestSuccess(publicContext! , state.data);
    }
  }

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
  void onBuild(SoftCoreContext context) {
    this.softContext =  context ;
  }
   @override
  Widget softBuild(SoftCoreContext context) {
     return safeArea() ? SafeArea(
         child: buildScaffold(context.context)
     ):buildScaffold(context.context);
  }


  Widget buildScaffold(BuildContext context){
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: title(context)==null ?null:  mAppBar(context),
      body: scaffoldBody(context),
    );
  }
  Widget scaffoldBody(BuildContext context){
    return buildConsumer(context);
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

  ErrorPlaceHolderWidget placeHolderWidget(
      {exception, Function()? onClickReload}){
    return ErrorPlaceHolderWidget(error: errorManager(publicContext!).prepareError(exception),onRetryButton: onClickReload,);
  }

  void handleApiErrorDialog(error, BuildContext context) {
    final errorModel = errorManager(context).prepareError(error);
    dialogsManager(context).showMessageDialog(context, errorModel.message);
  }

  void onClickReload() {
    loadInitialData(publicContext!);
  }

  void onRequestSuccess(BuildContext context , successData) {}

  BlocConsumer buildConsumer(BuildContext context) {
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadInitialData(context);
    });
    return consumer;
  }


  handleErrorDialogBuilder(dynamic exception) {
    final context = Get.context!;
    dialogsManager(context).showMessageDialog(context, exception);
  }

  DialogsManager dialogsManager(BuildContext context){
    return DialogsManager();
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
}
