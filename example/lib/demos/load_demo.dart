import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softcore/softcore.dart';

import '../data/fake_api.dart';
import 'demo_scaffold.dart';

/// 1. BaseCubit.load + SoftBlocConsumer + a UseCase.
class UsersCubit extends BaseCubit<List<User>> {
  UsersCubit(this._getUsers);

  final GetUsers _getUsers;

  Future<void> loadUsers() => load(() => _getUsers(const NoParams()));
}

class LoadDemo extends StatelessWidget {
  const LoadDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UsersCubit(GetUsers(FakeApi.instance))..loadUsers(),
      child: Builder(
        builder: (context) => DemoScaffold(
          title: 'load + SoftBlocConsumer',
          explanation: 'load() emits loading, then data or an error. '
              'SoftBlocConsumer renders each one. Turn on failures and '
              'reload to see the error view and its Retry button.',
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => context.read<UsersCubit>().loadUsers(),
            ),
          ],
          body: SoftBlocConsumer<UsersCubit, List<User>>(
            onRetry: () => context.read<UsersCubit>().loadUsers(),
            builder: (context, users) => ListView(
              children: [
                for (final user in users)
                  ListTile(
                    leading: CircleAvatar(child: Text(user.name[0])),
                    title: Text(user.name),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
