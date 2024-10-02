import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softcore/src/di/softcore_injector.dart';

import '../../../di/error_handler_factory.dart';
import '../../managers/error_handler.dart';
import '../softcore_stateless_widget.dart';

/// Base stateless widget for handling Bloc states and side effects.
///
/// Developers can extend this widget to easily manage Bloc state-driven
/// UI and handle side effects for specific state changes.
///
/// [B] is the BlocBase, [S] is the state.
abstract class SoftCoreBlocStateless<T, B extends BlocBase<S>, S> extends SoftCoreStatelessWidget {
  final B? blocInstance;

  const SoftCoreBlocStateless({super.key, this.blocInstance});

  B get bloc => blocInstance ?? SoftCoreInjector.get<B>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      bloc: bloc,
      listener: (context, state) => handleStateChange(context, state),
      builder: (context, state) => buildStateWidget(context, state),
      buildWhen: buildWhen,
      listenWhen: listenWhen,
    );
  }

  /// Handle side effects when a specific state is reached.
  ///
  /// This method is called every time the state changes. Developers
  /// can override this method to trigger side effects, like showing
  /// snack bars, performing navigation, or logging.
  ///
  /// Use [listenWhen] to control which states should trigger this method.
  void handleStateChange(BuildContext context, S state) {}

  /// Build the UI based on the current state of the Bloc.
  ///
  /// Developers must override this method to define how the UI
  /// responds to different states.
  Widget buildStateWidget(BuildContext context, S state);

  /// A function to determine which states should trigger the listener
  bool listenWhen(S previous, S current) {
    return true;
  }

  /// A function to determine which states should trigger the builder
  bool buildWhen(S previous, S current) {
    return true;
  }

}
