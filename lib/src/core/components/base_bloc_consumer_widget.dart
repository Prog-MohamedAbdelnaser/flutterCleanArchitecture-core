import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softcore/basebloc.dart';

class BaseBlocConsumerBuilder<B extends BlocBase<S>, S> extends StatelessWidget {
  final B bloc;
  final Widget Function(BuildContext context, S state) builder;
  final void Function(BuildContext context, S state)? listener;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, String message)? errorBuilder;

  const BaseBlocConsumerBuilder({
    Key? key,
    required this.bloc,
    required this.builder,
    this.listener,
    this.loadingBuilder,
    this.errorBuilder,
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
      listener: listener ?? (context, state) {},
      builder: (context, state) {
        if (state is DataLoading && loadingBuilder != null) {
          return loadingBuilder!(context);
        } else if (state is DataFailed && errorBuilder != null) {
          return errorBuilder!(context, (state).error);
        } else {
          return builder(context, state);
        }
      },
    );
  }
}
