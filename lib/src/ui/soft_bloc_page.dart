import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/base_cubit.dart';
import 'soft_bloc_consumer.dart';

/// A whole screen driven by a [BaseCubit]: creates the cubit, loads once,
/// renders loading/error/data, handles actions, and closes the cubit.
///
/// ```dart
/// class UsersPage extends SoftBlocPage<UsersCubit, List<User>> {
///   const UsersPage({super.key});
///
///   @override
///   UsersCubit createBloc(BuildContext context) => UsersCubit(repository);
///
///   @override
///   void onInit(UsersCubit bloc) => bloc.loadUsers();
///
///   @override
///   String? title(BuildContext context) => 'Users';
///
///   @override
///   Widget buildData(BuildContext context, UsersCubit bloc, List<User> users) =>
///       UsersList(users);
/// }
/// ```
///
/// The cubit is provided to the subtree, so children can use
/// `context.read<UsersCubit>()`. For anything this does not cover, use
/// `SoftBlocConsumer` in your own widget.
abstract class SoftBlocPage<B extends BaseCubit<T>, T> extends StatefulWidget {
  /// Const constructor for subclasses.
  const SoftBlocPage({super.key});

  /// Creates the cubit. Called once. Return an existing instance (e.g. from
  /// your service locator) and set [closeBlocOnDispose] to `false` if this
  /// page does not own it.
  B createBloc(BuildContext context);

  /// Builds the screen's data.
  Widget buildData(BuildContext context, B bloc, T data);

  /// Called once after the cubit is created, and again by the error view's
  /// retry button. Start loading here.
  void onInit(B bloc) {}

  /// Called when an action succeeds.
  void onActionSuccess(BuildContext context, B bloc, Object? result) {}

  /// Whether this page closes the cubit when it is removed.
  bool get closeBlocOnDispose => true;

  /// The app bar title; no app bar when `null`.
  String? title(BuildContext context) => null;

  /// Wraps the body. Override for a custom scaffold, tabs, a FAB, etc.
  Widget buildScaffold(BuildContext context, B bloc, Widget body) {
    final text = title(context);
    return Scaffold(
      appBar: text == null ? null : AppBar(title: Text(text)),
      body: SafeArea(child: body),
    );
  }

  @override
  State<SoftBlocPage<B, T>> createState() => _SoftBlocPageState<B, T>();
}

class _SoftBlocPageState<B extends BaseCubit<T>, T>
    extends State<SoftBlocPage<B, T>> {
  late final B _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = widget.createBloc(context);
    widget.onInit(_bloc);
  }

  @override
  void dispose() {
    if (widget.closeBlocOnDispose) _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>.value(
      value: _bloc,
      child: Builder(
        builder: (context) => widget.buildScaffold(
          context,
          _bloc,
          SoftBlocConsumer<B, T>(
            bloc: _bloc,
            onRetry: () => widget.onInit(_bloc),
            onActionSuccess: (context, result) =>
                widget.onActionSuccess(context, _bloc, result),
            builder: (context, data) => widget.buildData(context, _bloc, data),
          ),
        ),
      ),
    );
  }
}
