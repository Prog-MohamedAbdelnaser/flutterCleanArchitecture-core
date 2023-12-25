import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

abstract class CommonState  extends Equatable{

  @override
  List<Object?> get props =>[];

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

  close() {
    _streamController.close();
  }
}
class StreamStateInitial<T> extends StreamState<T> {
  @override
  bool get hasData => data != null;

  @override
  bool get hasError => error != null;
}