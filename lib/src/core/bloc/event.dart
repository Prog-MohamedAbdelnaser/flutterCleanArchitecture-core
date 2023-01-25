
import '../../main_index.dart';

@immutable
abstract class BaseEvents {
  Stream<DataState> applyAsync(
      {required DataState currentState,
      required Bloc<BaseEvents, DataState> bloc});
}
