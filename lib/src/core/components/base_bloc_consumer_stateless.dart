import '../../../main_index.dart';

abstract class BaseBlocConsumerStateless<B extends BlocBase<S>, S> extends MaterialStatelessWidget {

  const BaseBlocConsumerStateless({Key? key}) : super(key: key);

  B get bloc ;

  B? initBloc(BuildContext context) {
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      bloc: bloc,
      listener: (context, state) => handleStateChange(context, state),
      builder: (context, state) => buildStateWidget(context, state),
    );
  }


  /// Method to handle different state changes
  void handleStateChange(BuildContext context, S state);

  /// Method to build the widget based on the current state
  Widget buildStateWidget(BuildContext context, S state);
}