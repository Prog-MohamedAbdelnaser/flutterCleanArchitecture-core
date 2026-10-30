import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_state.dart';

/// An independent piece of loadable data inside a bigger cubit.
///
/// Use it when one screen shows several sections that load separately
/// (a profile header and a notifications list, say): each section gets its
/// own observer with its own loading/error/data, instead of fighting over
/// the cubit's single state.
///
/// It is a regular [Cubit], so it works with `BlocBuilder`, `BlocListener`
/// and softcore's `DataObserverBuilder`.
class DataObserver<T> extends Cubit<DataState<T>> {
  /// Creates an observer starting at [DataInitial].
  DataObserver() : super(DataInitial<T>());

  int _request = 0;

  /// Runs [request] and emits loading, then success or failure.
  ///
  /// If [load] is called again before an earlier request finishes, the
  /// earlier result is dropped, so a slow old response never overwrites a
  /// newer one.
  Future<void> load(Future<T> Function() request) async {
    final id = ++_request;
    _emitIfOpen(DataLoading<T>());
    try {
      final data = await request();
      if (id == _request) _emitIfOpen(DataSuccess<T>(data));
    } catch (error, stackTrace) {
      if (id == _request) _emitIfOpen(DataFailed<T>(error, stackTrace));
    }
  }

  /// Sets the data directly.
  void setData(T data) {
    _request++;
    _emitIfOpen(DataSuccess<T>(data));
  }

  /// The current data, or `null` if not loaded.
  T? get data => state.dataOrNull;

  void _emitIfOpen(DataState<T> state) {
    if (!isClosed) emit(state);
  }
}
