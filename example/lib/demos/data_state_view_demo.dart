import 'package:flutter/material.dart';
import 'package:softcore/softcore.dart';

/// 9. DataStateView: render any DataState you hold, no bloc needed. Useful
/// inside your own BlocBuilder, a FutureBuilder, or a design-system gallery.
class DataStateViewDemo extends StatefulWidget {
  const DataStateViewDemo({super.key});

  @override
  State<DataStateViewDemo> createState() => _DataStateViewDemoState();
}

class _DataStateViewDemoState extends State<DataStateViewDemo> {
  static const _states = <String, DataState<String>>{
    'Initial': DataInitial(),
    'Loading': DataLoading(),
    'Data': DataSuccess('Hello from DataSuccess'),
    'Error': DataFailed(SoftException('Something broke')),
  };

  String _selected = 'Data';

  @override
  Widget build(BuildContext context) {
    final state = _states[_selected]!;
    return Scaffold(
      appBar: AppBar(title: const Text('DataStateView')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SegmentedButton<String>(
              segments: [
                for (final name in _states.keys)
                  ButtonSegment(value: name, label: Text(name)),
              ],
              selected: {_selected},
              onSelectionChanged: (value) =>
                  setState(() => _selected = value.first),
            ),
          ),
          // Plain Dart pattern matching works on any DataState.
          Text(switch (state) {
            DataLoading() => 'switch: loading',
            DataSuccess(:final data) => 'switch: ${data.length} characters',
            DataFailed() => 'switch: failed',
            _ => 'switch: nothing loaded yet',
          }),
          Expanded(
            child: DataStateView<String>(
              state: state,
              initialBuilder: (_) =>
                  const Center(child: Text('Nothing loaded yet')),
              onRetry: () => setState(() => _selected = 'Loading'),
              builder: (context, text) => Center(
                child: Text(text,
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
