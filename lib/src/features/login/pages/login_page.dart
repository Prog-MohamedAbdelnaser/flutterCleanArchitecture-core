import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../core/resources/data_state.dart';
import '../../../core/components/base_widget_bloc.dart';
import '../bloc/login_bloc.dart';
import 'login_screen.dart';
class LoginPage extends BaseBlocWidget<UnInitState , LoginBloc>{

  @override
  Widget buildWidget(BuildContext context, UnInitState state) {
    return LoginScreen(onClickLogin: (){
      bloc.login();
    },);
  }


  @override
  void onRequestSuccess(String? message) {

  }

}