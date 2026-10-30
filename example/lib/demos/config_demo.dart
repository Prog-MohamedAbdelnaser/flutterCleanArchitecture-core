import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softcore/softcore.dart';

import '../data/fake_api.dart';
import 'demo_scaffold.dart';

/// 8. SoftCore config: a custom error mapper, loading view, error view,
/// error messenger and progress presenter, here applied to one screen.
/// Wrap your whole app with SoftCore to apply them everywhere.
SoftError mapApiErrors(BuildContext context, Object error) {
  if (error is ApiError) {
    return SoftError(
      title: 'Server error',
      message: error.statusCode == 503
          ? 'The store is under maintenance. Try again in a minute.'
          : 'Something went wrong (${error.statusCode}).',
      code: '${error.statusCode}',
      cause: error,
    );
  }
  return defaultErrorMapper(context, error);
}

final demoConfig = SoftCoreConfig(
  errorMapper: mapApiErrors,
  retryLabel: 'Try again',
  loadingBuilder: (context) => const Center(child: LinearProgressIndicator()),
  errorBuilder: (context, error, onRetry) => Center(
    child: Card(
      margin: const EdgeInsets.all(24),
      child: ListTile(
        leading: const Icon(Icons.cloud_off),
        title: Text(error.title ?? 'Oops'),
        subtitle: Text(error.message),
        trailing: onRetry == null
            ? null
            : IconButton(icon: const Icon(Icons.refresh), onPressed: onRetry),
      ),
    ),
  ),
  errorMessenger: (context, error) => showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(error.title ?? 'Could not reserve'),
      content: Text(error.message),
    ),
  ),
  progressBuilder: (context) => const Center(
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('Reserving…'),
      ),
    ),
  ),
);

class StockCubit extends BaseCubit<int> {
  StockCubit(this._api);

  final FakeApi _api;

  Future<void> loadStock() => load(_api.getStock);

  Future<void> reserve() => runAction(() async {
        await Future<void>.delayed(const Duration(seconds: 1));
        if ((data ?? 0) == 0) throw const ApiError(409);
        updateData((stock) => stock - 1);
      });
}

class ConfigDemo extends StatelessWidget {
  const ConfigDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SoftCore(
      config: demoConfig,
      child: BlocProvider(
        create: (_) => StockCubit(FakeApi.instance)..loadStock(),
        child: Builder(builder: (context) {
          final cubit = context.read<StockCubit>();
          return DemoScaffold(
            title: 'SoftCore config',
            explanation: 'Same widgets, different look: a linear loader, a '
                'card error view, an ApiError mapped to a friendly message, '
                'and a custom progress dialog. Reserve with 0 in stock to see '
                'the custom error messenger.',
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: cubit.loadStock,
              ),
            ],
            body: SoftBlocConsumer<StockCubit, int>(
              onRetry: cubit.loadStock,
              builder: (context, stock) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$stock in stock',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: cubit.reserve,
                      child: const Text('Reserve one'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
