import 'package:get/get.dart';

import '../../../main_index.dart';
import '../dialogs/progress_dialog.dart';
import 'package:get_it/get_it.dart';

abstract class MaterialBlocWidget<T, B extends BlocBase<DataState>>
    extends MaterialStatelessWidget {


  B get bloc => GetIt.instance.get<B>();


  const MaterialBlocWidget({Key? key}) : super(key: key);

  @protected
  Widget buildWidget(BuildContext context, T state);


  showProgress() {
    progress.show();
  }

  dismissProgress() {
    progress.dismiss();
  }

  CustomProgressDialog get progress => dialogsManager(gContext!).createProgress(gContext!);
  
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

  ErrorPlaceHolderWidget errorWidget(
      {exception, Function()? onClickReload}){
    return ErrorPlaceHolderWidget(error: errorManager(gContext!).prepareError(exception),onRetryButton: onClickReload,);
  }

  void handleApiErrorDialog(error, BuildContext context) {
    final errorModel = errorManager(context).prepareError(error);
    dialogsManager(context).showMessageDialog(context, errorModel.message);
  }

  void onClickReload(BuildContext context) {
    loadInitialData(context);
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
        builder: (context, state) => buildStateWidget(context,state),
        listener: (context, state) => handleStateChange(context, state));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadInitialData(context);
    });
    return consumer;
  }

  void onBuild(BuildContext context) {}

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

  /// Method to handle different state changes
  void handleStateChange(BuildContext context, DataState state){
    return _buildListener(context, state);
  }

  /// Method to build the widget based on the current state
  Widget buildStateWidget(BuildContext context, DataState state){
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
