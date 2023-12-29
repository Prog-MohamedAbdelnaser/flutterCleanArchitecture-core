
abstract class DataState<T> {
  final T ? data;
  final dynamic error;

  const DataState({this.data, this.error});
}

class UnInitState extends DataState {}

/**
 * this state for observe state with bloc listeners
 **/
abstract class DataStateFListener<T> extends DataState<T> {
  const DataStateFListener({data, error}):super(data: data,error: error);
}

class LoadingStateListener extends DataStateFListener {}

class FailureStateListener extends DataStateFListener {
  FailureStateListener(error):super(error: error);
}

class SuccessStateListener<T> extends DataStateFListener<T> {
  final T? data;

  SuccessStateListener(this.data);
}



/**
 * this state for observe state with bloc builder
 **/

abstract class DataStateFBuilder<T> extends DataState<T> {
  const DataStateFBuilder({data, error}):super(data: data,error: error);
}

class DataFailed<T> extends DataStateFBuilder<T> {
  const DataFailed(error) : super(error: error);
}

class DataSuccess<T> extends DataStateFBuilder<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataLoading extends DataStateFBuilder {}