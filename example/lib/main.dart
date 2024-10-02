import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:softcore/softMaterials.dart';
import 'package:support/config/Themes/themes.dart';

import 'injector.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  
  // Optionally configure the DefaultErrorWidgetFactory if needed
  // For instance, you can set up default configurations for error widgets
  // DefaultErrorWidgetFactory.configureDefaults(...);

  runApp(const RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));

    return SoftCoreApp(
      title: 'Flutter Demo',
      theme: kAppTheme,
      onInit: (){

      },
      errorWidgetFactory: DefaultStatesWidgetFactory(),
      errorHandler: DefaultErrorHandler.instance,
      dialogsManager: DefaultDialogsManager(),
      home: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.white,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ), dependencyInjector: MyCustomDependencyInjector(),
    );
  }
}
