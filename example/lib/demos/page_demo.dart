import 'package:flutter/material.dart';
import 'package:softcore/softcore.dart';

import '../data/fake_api.dart';
import 'load_demo.dart';

/// 5. SoftBlocPage: a whole screen in one class. It creates the cubit,
/// loads once, renders every state, provides the cubit to children, and
/// closes it when the page goes away.
class UsersPage extends SoftBlocPage<UsersCubit, List<User>> {
  const UsersPage({super.key});

  @override
  UsersCubit createBloc(BuildContext context) =>
      UsersCubit(GetUsers(FakeApi.instance));

  @override
  void onInit(UsersCubit bloc) => bloc.loadUsers();

  @override
  String? title(BuildContext context) => 'SoftBlocPage';

  @override
  Widget buildData(BuildContext context, UsersCubit bloc, List<User> users) {
    return RefreshIndicator(
      onRefresh: bloc.loadUsers,
      child: ListView(
        children: [
          const ListTile(
            title: Text('This screen is one SoftBlocPage subclass: it '
                'creates, loads, renders and closes its cubit. Pull to '
                'refresh.'),
          ),
          for (final user in users)
            ListTile(
              leading: CircleAvatar(child: Text(user.name[0])),
              title: Text(user.name),
            ),
        ],
      ),
    );
  }
}
