/// A single business operation, the "use case" of clean architecture.
///
/// ```dart
/// class GetUser implements UseCase<User, String> {
///   GetUser(this.repository);
///   final UserRepository repository;
///
///   @override
///   Future<User> call(String id) => repository.getUser(id);
/// }
/// ```
abstract interface class UseCase<T, P> {
  /// Runs the use case with [params].
  Future<T> call(P params);
}

/// Params for a [UseCase] that takes none.
final class NoParams {
  /// The only instance.
  const NoParams();
}
