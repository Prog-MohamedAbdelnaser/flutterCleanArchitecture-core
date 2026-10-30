/// A thin, predictable state layer on top of flutter_bloc.
///
/// * State: [DataState], [BaseCubit], [DataObserver], [SoftCache].
/// * Widgets: [SoftBlocConsumer], [SoftBlocListener],
///   [DataObserverBuilder], [SoftBlocPage], [DataStateView].
/// * Config: [SoftCore], [SoftCoreConfig], [ErrorMapper].
/// * Errors: [SoftException], [LocalizedException], [SoftError].
/// * Clean architecture: [UseCase], [NoParams].
library;

export 'src/clean/use_case.dart';
export 'src/errors/soft_error.dart';
export 'src/errors/soft_exception.dart';
export 'src/state/action_result.dart';
export 'src/state/base_cubit.dart';
export 'src/state/data_observer.dart';
export 'src/state/data_state.dart';
export 'src/state/soft_cache.dart';
export 'src/ui/action_handler.dart'
    show ActionErrorCallback, ActionSuccessCallback;
export 'src/ui/data_observer_builder.dart';
export 'src/ui/data_state_view.dart';
export 'src/ui/default_views.dart';
export 'src/ui/soft_bloc_consumer.dart';
export 'src/ui/soft_bloc_listener.dart';
export 'src/ui/soft_bloc_page.dart';
export 'src/ui/soft_core_config.dart';
