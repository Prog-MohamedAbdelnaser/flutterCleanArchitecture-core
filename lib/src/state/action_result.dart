/// The outcome of `BaseCubit.runAction`.
///
/// ```dart
/// final result = await cubit.runAction(() => api.save(form));
/// if (result.isSuccess) print('Saved ${result.value}');
/// ```
final class ActionResult<R> {
  /// A successful outcome holding [value].
  const ActionResult.success(R this.value)
      : isSuccess = true,
        error = null,
        stackTrace = null;

  /// A failed outcome holding [error].
  const ActionResult.failure(Object this.error, [this.stackTrace])
      : isSuccess = false,
        value = null;

  /// Whether the action succeeded.
  final bool isSuccess;

  /// What the action returned, if it succeeded.
  final R? value;

  /// What went wrong, if it failed.
  final Object? error;

  /// Where it went wrong, if it failed.
  final StackTrace? stackTrace;

  /// Whether the action failed.
  bool get isFailure => !isSuccess;

  @override
  String toString() => isSuccess
      ? 'ActionResult.success($value)'
      : 'ActionResult.failure($error)';
}
