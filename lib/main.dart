import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'src/core/network/client/base_client.dart';
import 'src/main_index.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await configureDependencies();
  injector.registerSingleton(ClientCreator(
      interceptor: HeaderInterceptor(
    accessToken: '',
  )).create());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: kAppTheme,
      debugShowCheckedModeBanner: false,
      locale: Locale('ar'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English, no country code
        Locale('ar'), // Arabic, no country code
      ],
      routes: Routs.routes,
      initialRoute: Routs.intro,
    );
  }
}
