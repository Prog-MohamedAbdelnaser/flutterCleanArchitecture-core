## 1.0.0

A rewrite focused on reliability and a small, predictable API. It now depends
only on `flutter_bloc` (8.x or 9.x) and works on every platform, web included.

### Added

- `BaseCubit<T>` with `load` (latest request wins, optional cache with TTL),
  `runAction` (returns an `ActionResult`, never throws), and `emitLoading`,
  `emitData`, `emitError`, `emitState`, `updateData` to manage state by hand.
- `DataState` split into screen states (`DataInitial`, `DataLoading`,
  `DataSuccess`, `DataFailed`) and one-shot action states (`ActionLoading`,
  `ActionSuccess`, `ActionFailed`). Both families are open for your own
  subclasses, and all states have value equality.
- `DataObserver` and `BaseCubit.observe` for sections of a screen that load
  independently, rendered with `DataObserverBuilder`.
- `SoftBlocConsumer`, `SoftBlocListener`, `SoftBlocPage`, `DataStateView`.
- `SoftCore` / `SoftCoreConfig` to set loading, error, initial and progress
  views, the error messenger and an `ErrorMapper` once for the whole app.
- `SoftException` and `LocalizedException` for user-facing errors.

### Fixed (compared with 0.x)

- A slow earlier request no longer overwrites a newer one.
- Nothing is emitted after the cubit is closed; observers are closed with it.
- Action errors no longer escape as unhandled exceptions.
- The progress dialog always closes, and closes only itself, never a dialog
  or page opened on top of it.
- Pages no longer reload on every rebuild.
- Adding a custom listener no longer turns off progress and error handling.
- Errors no longer depend on `Get.context` or crash above `MaterialApp`.
- String errors and Arabic/English messages are shown correctly.

### Breaking changes

- Removed the GetX, get_it, Dio, retrofit, injectable and UI-kit
  dependencies and widgets. Map Dio (or any) errors with an `ErrorMapper`.
- State names changed: `UnInitState` → `DataInitial`,
  `LoadingStateListener` → `ActionLoading`, `SuccessStateListener` →
  `ActionSuccess`, `FailureStateListener` → `ActionFailed`,
  `DataStateFBuilder` → `BuildState`, `DataStateFListener` → `ActionState`.
- `executeEmitterData` → `load`, `executeEmitterListener` → `runAction`,
  `executeEmitterObserver` → `observe`, `findObserver` → `observer`.
- `MaterialBlocWidget` → `SoftBlocPage`; `StreamDataStateWidget` →
  `DataObserverBuilder`.
- Cache keys are explicit strings (`cacheKey:`) instead of type hash codes.

## 0.2.0

- Initial public release.
