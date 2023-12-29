import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


extension AppResource on BuildContext {

  InputDecoration inputDecoration() => const InputDecoration().applyDefaults(theme.inputDecorationTheme);

  Locale getLocal() {
    Locale myLocale = Localizations.localeOf(this);
    return myLocale;
  }

  String getLanguageCode() {
    Locale myLocale = Localizations.localeOf(this);
    return myLocale.languageCode;
  }

  T? getArguments<T>(){
    return ModalRoute.of(this)!.settings.arguments as T;
  }

}

extension NullOrEmpty on String? {
  bool isNullOrEmpty() {
    return this == null || this!.trim().isEmpty ;
  }


}