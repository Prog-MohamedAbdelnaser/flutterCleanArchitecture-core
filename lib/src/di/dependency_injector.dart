abstract class DependencyInjector {


  // Get the instance of a singleton
  T get<T extends Object>();

  // Check if a singleton is registered
  bool isRegistered<T extends Object>();
}
