import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/data_state.dart';

abstract class BaseCubit extends Cubit<DataState>{
  BaseCubit() : super(UnInitState());
}