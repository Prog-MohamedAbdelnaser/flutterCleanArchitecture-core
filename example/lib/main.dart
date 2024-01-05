import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:softcore/softMaterials.dart';
import 'package:support/config/Themes/themes.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

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

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: kAppTheme,
      debugShowCheckedModeBanner: false,
      home: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.white,
          child: Container(
            child: Material(child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialTextField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialTextField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialTextField(),
                ),

              ],
            )),
          ),
        ),
      ),
    );
  }
}
