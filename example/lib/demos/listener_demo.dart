import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softcore/softcore.dart';

import '../data/fake_api.dart';
import 'demo_scaffold.dart';

/// 6. SoftBlocListener: a form driven by actions only, no data to render.
class LoginCubit extends BaseCubit<void> {
  LoginCubit(this._api);

  final FakeApi _api;

  Future<void> login(String email, String password) =>
      runAction(() => _api.login(email, password));
}

class ListenerDemo extends StatefulWidget {
  const ListenerDemo({super.key});

  @override
  State<ListenerDemo> createState() => _ListenerDemoState();
}

class _ListenerDemoState extends State<ListenerDemo> {
  final TextEditingController _email =
      TextEditingController(text: 'amira@example.com');
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(FakeApi.instance),
      child: DemoScaffold(
        title: 'SoftBlocListener',
        explanation: 'Sign in shows progress, then a message on failure or a '
            'success dialog. The password is "secret".',
        body: SoftBlocListener<LoginCubit, void>(
          onActionSuccess: (context, _) => showDialog<void>(
            context: context,
            builder: (_) => const AlertDialog(content: Text('Signed in')),
          ),
          child: Builder(
            builder: (context) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => context
                      .read<LoginCubit>()
                      .login(_email.text, _password.text),
                  child: const Text('Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
