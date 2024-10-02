import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softcore/main_index.dart';
import '../../../../errorManager.dart';
import '../../../../softMaterials.dart';
import '../../../di/error_handler_factory.dart';
import '../../../di/states_widgets_factory.dart';
import '../../../di/states_widget_factory_registry.dart';
import '../../dialogs/dialogs_manager.dart';
import '../../managers/error_handler.dart';

class SoftCoreApp extends StatelessWidget {
  final Widget home;
  final String? title; // Dynamic title
  final ThemeData? theme;
  final Locale? locale;
  final List<LocalizationsDelegate>? localizationsDelegates;
  final Iterable<Locale>? supportedLocales;
  final ErrorHandler? errorHandler;
  final DialogsManager? dialogsManager;
  final StatesWidgetFactory? errorWidgetFactory;
  final DependencyInjector dependencyInjector ;
  final void Function()? onInit;

  SoftCoreApp({
    Key? key,
    required this.home,
    this.title, // Accept title as a parameter
    this.theme,
    this.locale,
    this.localizationsDelegates,
    this.supportedLocales,
    this.errorHandler,
    this.errorWidgetFactory,
    this.onInit,required this.dependencyInjector,this.dialogsManager
  }) : super(key: key){
    _initializeHandler();
  }

  @override
  Widget build(BuildContext context) {

    // Optionally run the init function if provided
    WidgetsBinding.instance.addPostFrameCallback((_) => onInit?.call());

    return GetMaterialApp(
      title: title ?? '', // Set dynamic title
      theme: theme ?? ThemeData.light(),
      locale: locale,debugShowCheckedModeBanner: false,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales ?? const [Locale('en', 'US')],
      home: home,
    );
  }

  void _initializeHandler() {
    SoftCoreInjector.initialize(dependencyInjector!);
      // Register a default error handler if none provided
    ErrorHandlerFactory.setCustomErrorHandler(
      errorHandler ?? DefaultErrorHandler.instance,
    );

    if (errorWidgetFactory != null) {
      StatesWidgetsFactoryRegistry.setCustomErrorWidgetFactory(
          errorWidgetFactory!);
    }
  }
}
