
import 'package:rxdart/rxdart.dart';

abstract class DataState<T> {

}

class UnInitState<T> extends DataStateFBuilder<T> {}

/**
 * this state for observe state with bloc listeners
 **/
abstract class DataStateFListener<T> extends DataState<T> {

}

class LoadingStateListener extends DataStateFListener {}

class FailureStateListener extends DataStateFListener {
  final dynamic error ;
  FailureStateListener(this. error);
}

class SuccessStateListener<T> extends DataStateFListener<T> {
  final T? data;

  SuccessStateListener(this.data);
}



/**
 * this state for observe state with bloc builder
 **/

abstract class DataStateFBuilder<T> extends DataState<T> {

}

class DataFailed<T> extends DataStateFBuilder<T> {
  final dynamic error ;
   DataFailed(this.error) ;
}

class DataSuccess<T> extends DataStateFBuilder<T> {
  final T data ;
   DataSuccess( this. data);
}

class DataLoading<T> extends DataStateFBuilder<T> {}


abstract class StreamDataState<T> {

  final _streamController = BehaviorSubject<DataState<T>>();
  Stream<DataState<T>> get stream => _streamController.stream;

  bool isSame<S>(S s){
    return T is S;
  }
  start(){
    _streamController.add(DataLoading());

  }
  setError(dynamic initError) {
    _streamController.add(DataFailed(initError));
  }

  setData(T initData) {
    _streamController.add(DataSuccess(initData));
  }

  clearData(){
    _streamController.add(UnInitState());
  }

  setFutureData(Future<T> Function() invoke,{Function(dynamic e)? onError}) async {
    try {
      T response = await invoke();
      setData(response);
    } catch (e) {
      print('setFutureData error ${e}');
      setError(e);
      if(onError!=null)onError(e);
    }
  }

  close() {
    _streamController.sink.close();
  }
}

class StreamDataStateInitial<T> extends StreamDataState<T> {

}


abstract class StreamState<T> {
  dynamic error;
  bool get hasError;
  bool get hasData;
  T? data;

  final _streamController = BehaviorSubject<T>();
  Stream<T> get stream => _streamController.stream;

  setError(dynamic initError) {
    error = initError;
    _streamController.addError(initError);
    data = null;
  }

  setData(T initData) {
    data = initData;
    _streamController.add(initData);
    error = null;
  }

  setFutureData(Future<T> Function() invoke,{Function(dynamic e)? onError}) async {
    try {
      T response = await invoke();
      setData(response);
    } catch (e) {
      setError(e);
      if(onError!=null)onError(e);
    }
  }

  close() {
    _streamController.sink.close();
  }
}

class StreamStateInitial<T> extends StreamState<T> {
  @override
  bool get hasData => data != null;

  @override
  bool get hasError => error != null;
}