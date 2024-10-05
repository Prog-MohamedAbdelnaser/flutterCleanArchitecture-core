import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:softcore/softMaterials.dart';
import 'package:support/homecubit.dart';

class HomePage extends SoftBlocWidget<DataSuccess,HomeCubit>{
  @override
  Widget buildWidget(BuildContext context, state) {
    return Container();
  }

  @override
  void loadInitialData(BuildContext context) {
    bloc.fetch();
  }

  @override
  HomeCubit get bloc => HomeCubit();
}