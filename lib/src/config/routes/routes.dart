import 'package:flutter/cupertino.dart';

import '../../features/home/pages/home_page.dart';
import '../../features/login/pages/login_page.dart';
import '../../features/splash/splash.dart';

class Routs{
  static const String languagePage = 'language_page';
  static const String login = 'loginUI';
  static const String intro = '/';
  static const String support = 'support';
  static const String home = 'home';
  static final routes = <String, Widget Function(BuildContext)>{
    intro: (context) => Splash(),
    login: (context) => LoginPage(),
    home: (context) => HomePage(),
  };

}