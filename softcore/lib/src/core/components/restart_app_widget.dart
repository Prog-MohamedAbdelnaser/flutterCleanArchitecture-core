
import 'package:flutter/cupertino.dart';


class RestartWidget extends StatefulWidget {
  const RestartWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  static void restartApp(BuildContext context, {String ? routeName}) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
    Navigator.pushNamedAndRemoveUntil(context ,routeName??'/', (Route<dynamic> route) => false);

  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
