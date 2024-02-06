import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main_index.dart';
import 'material_stateless_widget.dart';

class ConsumerBuilder extends StatelessWidget{
  final Widget Function(DataState state) builder ;
  final Function(DataState state)? listener ;
  final BlocBuilderCondition<DataState>? buildWhen;

  final BlocBase? bloc ;

  const ConsumerBuilder({Key? key, required this.builder,  this.listener,  this.bloc, this.buildWhen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return buildConsumer(context,bloc);
  }

  BlocConsumer buildConsumer(BuildContext context , BlocBase? bloc) {
    return BlocConsumer(
        bloc: bloc,
        listenWhen: (state, current) => current is DataStateFListener,
        buildWhen: (state, current) => buildWhen!=null ? buildWhen!(state,current): current is DataStateFBuilder,
        builder: (context, state) {
           return builder(state) ;
        },
        listener: (context, state)  {
         if(listener!=null) listener!(state);
        });
  }
}