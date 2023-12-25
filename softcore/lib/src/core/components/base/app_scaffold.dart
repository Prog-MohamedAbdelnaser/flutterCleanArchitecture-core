import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final List<Widget>? actions;
  final Widget? leading;
  const AppScaffold({Key? key, this.title, required this.body, this.floatingActionButton, this.drawer, this.actions, this.leading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ''),
        actions: actions,
        leading: leading,
      ),
      drawer: drawer,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
