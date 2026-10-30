import 'package:flutter/material.dart';

import '../data/fake_api.dart';

/// Common frame for the demos: a title, a short explanation, and a switch
/// that makes the fake API fail so you can see error handling.
class DemoScaffold extends StatefulWidget {
  const DemoScaffold({
    super.key,
    required this.title,
    required this.explanation,
    required this.body,
    this.actions = const [],
    this.floatingActionButton,
  });

  final String title;
  final String explanation;
  final Widget body;
  final List<Widget> actions;
  final Widget? floatingActionButton;

  @override
  State<DemoScaffold> createState() => _DemoScaffoldState();
}

class _DemoScaffoldState extends State<DemoScaffold> {
  final FakeApi _api = FakeApi.instance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: widget.actions),
      floatingActionButton: widget.floatingActionButton,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: theme.colorScheme.surfaceContainerHighest,
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.explanation, style: theme.textTheme.bodyMedium),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: const Text('Make requests fail'),
                  value: _api.failRequests,
                  onChanged: (value) =>
                      setState(() => _api.failRequests = value),
                ),
              ],
            ),
          ),
          Expanded(child: widget.body),
        ],
      ),
    );
  }
}
