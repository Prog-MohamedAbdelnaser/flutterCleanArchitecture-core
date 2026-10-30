import 'package:flutter/material.dart';
import 'package:softcore/softcore.dart';

import '../data/fake_api.dart';
import 'demo_scaffold.dart';

/// 3. Caching: a cache key, a time-to-live, forced refresh, and keeping the
/// data on screen while refreshing.
class CachedUsersCubit extends BaseCubit<List<User>> {
  CachedUsersCubit(this._api);

  final FakeApi _api;

  Future<void> loadUsers({bool refresh = false}) => load(
        _api.getUsers,
        cacheKey: 'users',
        cacheTtl: const Duration(seconds: 30),
        forceRefresh: refresh,
        keepDataWhileLoading: refresh,
      );
}

class CacheDemo extends StatefulWidget {
  const CacheDemo({super.key});

  @override
  State<CacheDemo> createState() => _CacheDemoState();
}

class _CacheDemoState extends State<CacheDemo> {
  final CachedUsersCubit _cubit = CachedUsersCubit(FakeApi.instance);

  @override
  void initState() {
    super.initState();
    _cubit.loadUsers();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'Caching',
      explanation: '"Load" uses the cache for 30 seconds, so the request '
          'counter stays the same. Pull down to force a refresh: the list '
          'stays visible while it reloads.',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                FilledButton(
                  onPressed: () async {
                    await _cubit.loadUsers();
                    setState(() {});
                  },
                  child: const Text('Load'),
                ),
                const SizedBox(width: 16),
                Text('Requests sent: ${FakeApi.instance.requestCount}'),
              ],
            ),
          ),
          Expanded(
            child: SoftBlocConsumer<CachedUsersCubit, List<User>>(
              bloc: _cubit,
              onRetry: () => _cubit.loadUsers(refresh: true),
              builder: (context, users) => RefreshIndicator(
                onRefresh: () async {
                  await _cubit.loadUsers(refresh: true);
                  setState(() {});
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    for (final user in users) ListTile(title: Text(user.name)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
