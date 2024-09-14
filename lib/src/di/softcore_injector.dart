import 'dependency_injector.dart';

class SoftCoreInjector {
  static late DependencyInjector _injector;

  // Initialize the library with a custom DependencyInjector implementation
  static void initialize(DependencyInjector injector) {
    _injector = injector;
  }

  static injector()=>_injector;

  // Example of using the injector to get a dependency
  static T get<T extends Object>() {
    return _injector.get<T>();
  }
}
