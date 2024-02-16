import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

class NotesItem implements ListItem {
  final String note;

  NotesItem(this.note);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      note,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

class MessageItem implements ListItem {
  final String message;

  MessageItem(this.message);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}
