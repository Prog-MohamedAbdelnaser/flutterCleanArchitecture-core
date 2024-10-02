import 'package:softcore/softMaterials.dart';


class HomeCubit extends BaseCubit{

  fetch(){
    emit(DataLoading());
    emit(DataFailed('error'));
  }
}