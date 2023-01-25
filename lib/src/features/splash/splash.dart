import 'package:flutter/material.dart';

import '../../config/routes/routes.dart';
import '../login/pages/login_page.dart';

class Splash extends StatelessWidget {
 static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    toNext(context);
    return Container();
  }

  Future<void> toNext(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, Routs.login);
  }
}
