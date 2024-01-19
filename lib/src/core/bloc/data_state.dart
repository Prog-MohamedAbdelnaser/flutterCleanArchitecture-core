
abstract class DataState<T> {

}

class UnInitState extends DataState {}

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

class DataLoading extends DataStateFBuilder {}