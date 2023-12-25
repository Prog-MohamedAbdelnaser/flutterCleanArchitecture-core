import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../exceptions/api_exception.dart';
import '../exceptions/app_exception.dart';

extension AppResource on BuildContext {

  InputDecoration inputDecoration() => const InputDecoration().applyDefaults(theme.inputDecorationTheme);

  AppLocalizations getStrings() {
    var stringRes = AppLocalizations.of(this);
    return stringRes! ;
  }

  T? getArguments<T>(){
    return ModalRoute.of(this)!.settings.arguments as T;
  }


  String handleApiErrorMessage({required dynamic exception}) {
    String message = 'undefine_error';
    return message;
  }

  ApiException handleApiError({required dynamic exception}) {
    String message = 'undefine_error';
    String code = "0";
    print('handleApiError message ${message}');
    return ApiException(message ,code );
  }


}

extension NullOrEmpty on String? {
  bool isNullOrEmpty() {
    return this == null || this!.trim().isEmpty ;
  }


}