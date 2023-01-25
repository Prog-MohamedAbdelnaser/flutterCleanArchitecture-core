import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/bloc/base_cubit.dart';
import '../../../core/resources/data_state.dart';
import '../../../domain/usecases/auhorization/authoization_usecases.dart';

@Injectable()
class LoginBloc extends BaseCubit{
  final AuthorizationUseCases authorizationUseCases ;
  LoginBloc(this.authorizationUseCases);
  login() async {
    try {
      emit(LoadingStateListener());
      await Future.delayed(Duration(milliseconds: 500));
      emit(SuccessStateListener(''));
    }catch(e){
      emit(DataFailed(e));
    }
  }
}