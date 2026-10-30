import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softcore/softcore.dart';

import '../data/fake_api.dart';
import 'demo_scaffold.dart';

/// 2. runAction: one-shot actions with progress, error messages, and
/// updating the list from the result without reloading.
class TeamCubit extends BaseCubit<List<User>> {
  TeamCubit(this._api);

  final FakeApi _api;

  Future<void> loadTeam() => load(_api.getUsers);

  Future<void> addMember(String name) => runAction(
        () => _api.addUser(name),
        onSuccess: (user) => updateData((users) => [...users, user]),
      );

  Future<void> removeMember(User user) => runAction(
        () => _api.deleteUser(user),
        onSuccess: (_) =>
            updateData((users) => users.where((u) => u != user).toList()),
      );
}

class ActionDemo extends StatelessWidget {
  const ActionDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TeamCubit(FakeApi.instance)..loadTeam(),
      child: Builder(
        builder: (context) => DemoScaffold(
          title: 'runAction',
          explanation: 'Adding or removing shows a progress dialog while the '
              'list stays on screen. Failures show a message; add an empty '
              'name to see a LocalizedException.',
          floatingActionButton: FloatingActionButton(
            onPressed: () => _askName(context),
            child: const Icon(Icons.person_add),
          ),
          body: SoftBlocConsumer<TeamCubit, List<User>>(
            onRetry: () => context.read<TeamCubit>().loadTeam(),
            onActionSuccess: (context, result) {
              final text = result is User ? 'Added ${result.name}' : 'Removed';
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(text)));
            },
            builder: (context, users) => ListView(
              children: [
                for (final user in users)
                  ListTile(
                    title: Text(user.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () =>
                          context.read<TeamCubit>().removeMember(user),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _askName(BuildContext context) async {
    final cubit = context.read<TeamCubit>();
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New member'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name != null) await cubit.addMember(name);
  }
}
