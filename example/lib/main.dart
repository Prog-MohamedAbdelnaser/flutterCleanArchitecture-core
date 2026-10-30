import 'package:flutter/material.dart';
import 'package:softcore/softcore.dart';

import 'demos/action_demo.dart';
import 'demos/cache_demo.dart';
import 'demos/config_demo.dart';
import 'demos/custom_states_demo.dart';
import 'demos/data_state_view_demo.dart';
import 'demos/listener_demo.dart';
import 'demos/load_demo.dart';
import 'demos/observer_demo.dart';
import 'demos/page_demo.dart';

void main() => runApp(const SoftcoreExampleApp());

class SoftcoreExampleApp extends StatelessWidget {
  const SoftcoreExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'softcore examples',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      // App-wide defaults for every softcore widget. Inside `builder`, so
      // dialogs and pushed pages get them too.
      builder: (context, child) => SoftCore(
        config: const SoftCoreConfig(retryLabel: 'Retry'),
        child: child!,
      ),
      home: const DemoList(),
    );
  }
}

class Demo {
  const Demo(this.title, this.subtitle, this.page);

  final String title;
  final String subtitle;
  final Widget page;
}

const demos = [
  Demo('load + SoftBlocConsumer', 'Loading, data, error and retry', LoadDemo()),
  Demo('runAction', 'Progress, error messages, updating data', ActionDemo()),
  Demo('Caching', 'cacheKey, cacheTtl, forceRefresh', CacheDemo()),
  Demo('observe + DataObserverBuilder', 'Independent sections on one screen',
      ObserverDemo()),
  Demo('SoftBlocPage', 'A whole screen in one class', UsersPage()),
  Demo('SoftBlocListener', 'Actions only: a login form', ListenerDemo()),
  Demo('Your own states', 'Extend BuildState and ActionState',
      CustomStatesDemo()),
  Demo('SoftCore config', 'Custom views, error mapper, progress', ConfigDemo()),
  Demo('DataStateView', 'Render any DataState directly', DataStateViewDemo()),
];

class DemoList extends StatelessWidget {
  const DemoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('softcore examples')),
      body: ListView.separated(
        itemCount: demos.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final demo = demos[index];
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(demo.title),
            subtitle: Text(demo.subtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => demo.page),
            ),
          );
        },
      ),
    );
  }
}
