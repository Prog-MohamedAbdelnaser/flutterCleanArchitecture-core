import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softcore/softcore.dart';

import '../data/fake_api.dart';
import 'demo_scaffold.dart';

/// 4. Observers: two sections of one screen load independently, each with
/// its own loading, error and retry, from one cubit.
class DashboardCubit extends BaseCubit<void> {
  DashboardCubit(this._api);

  final FakeApi _api;

  DataObserver<String> get profile => observer<String>('profile');
  DataObserver<List<String>> get notifications =>
      observer<List<String>>('notifications');

  void loadAll() {
    loadProfile();
    loadNotifications();
  }

  void loadProfile() => observe<String>('profile', _api.getProfileName);

  void loadNotifications() =>
      observe<List<String>>('notifications', _api.getNotifications);
}

class ObserverDemo extends StatelessWidget {
  const ObserverDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(FakeApi.instance)..loadAll(),
      child: Builder(builder: (context) {
        final cubit = context.read<DashboardCubit>();
        return DemoScaffold(
          title: 'observe + DataObserverBuilder',
          explanation: 'The profile loads fast and the notifications slowly; '
              'neither waits for the other. With failures on, retry each '
              'section on its own.',
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: cubit.loadAll,
            ),
          ],
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Profile', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(
                height: 120,
                child: DataObserverBuilder<String>(
                  observer: cubit.profile,
                  onRetry: cubit.loadProfile,
                  builder: (context, name) => ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(name),
                  ),
                ),
              ),
              const Divider(),
              Text('Notifications',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(
                height: 260,
                child: DataObserverBuilder<List<String>>(
                  observer: cubit.notifications,
                  onRetry: cubit.loadNotifications,
                  builder: (context, items) => Column(
                    children: [
                      for (final item in items)
                        ListTile(
                          leading: const Icon(Icons.notifications_none),
                          title: Text(item),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
