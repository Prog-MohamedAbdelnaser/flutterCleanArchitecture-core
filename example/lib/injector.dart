import 'package:get_it/get_it.dart';
import 'package:softcore/softMaterials.dart';


// Custom DependencyInjector implementation using get_it
class MyCustomDependencyInjector implements DependencyInjector {
  final GetIt _getIt = GetIt.instance;

  @override
  T get<T extends Object>() {
    return _getIt.get<T>();
  }

  @override
  bool isRegistered<T extends Object>() {
    return _getIt.isRegistered<T>();
  }

}
