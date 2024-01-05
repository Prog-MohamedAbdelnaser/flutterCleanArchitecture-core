import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softcore/main_index.dart';

import 'data_state.dart';

abstract class BaseCubit extends Cubit<DataState>{
  BaseCubit() : super(UnInitState());

  Map<String, dynamic> cashingModels = {};

  T? getFromCash<T>() {
    final key = T.hashCode.toString();
    if (cashingModels.containsKey(key)) {
      return cashingModels[key];
    }
    return null;
  }

  executeBuilder<T>(Future<T> Function() invoke,
      {required ValueChanged<T> onSuccess, bool enableCache = false}) async {
    try {

      emit(DataLoading());
      final value =await  executeCalling(invoke,enableCache: enableCache);
      onSuccess(value);
    } catch (e) {
      print('OnError ${e}');
      emit(DataFailed(e));
    }
  }

  Future<T> executeCalling<T>(Future<T> Function() invoke, { bool enableCache = false , String  ? tag}) async {
    final key = (tag??'')+T.hashCode.toString();
    if (enableCache == true && cashingModels.containsKey(key)) {
      return (cashingModels[key]);
    }

    final response = await invoke();
    if (response != null && enableCache == true) {
      cashingModels[key] = response;
      print('cashingModels $key => ${response}');

    }
    return (response);
  }
  executeListener<T>(Future<T> Function() invoke,
      {required ValueChanged<T> onSuccess}) async {
    try {
      emit(LoadingStateListener());
      final response = await invoke();
      onSuccess(response);
    } catch (e) {
      emit(FailureStateListener(e));
    }
  }

  executeEmitterListener<T>(Future<T> Function() invoke) {
    executeListener(() => invoke(), onSuccess: (v) {
      emit(SuccessStateListener<T>(v));
    });
  }

  executeEmitterData<T>(Future<T> Function() invoke,
      {bool enableCache = false}) {
    executeBuilder(enableCache: enableCache, () => invoke(), onSuccess: (v) {
      emit(
        DataSuccess<T>(v),
      );
    });
  }


  void emitErrorIfTypeIsGlobal(e){
    if (e is DioException) {
      if (e.error is SocketException || e.error is WebSocketException || e.error is HandshakeException ||
          e.type == DioExceptionType.connectionTimeout
          ||e.error is HttpException) {
        emit(DataFailed(e));
      }
    }
  }
}