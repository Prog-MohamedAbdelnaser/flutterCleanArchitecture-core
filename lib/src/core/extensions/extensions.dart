import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../exceptions/api_exception.dart';
import '../exceptions/app_exception.dart';
extension AppResource on BuildContext {

  AppLocalizations getStrings() {
    var stringRes = AppLocalizations.of(this);
    return stringRes! ;
  }

  T? getArguments<T>(){
    return ModalRoute.of(this)!.settings.arguments as T;
  }


  String handleApiErrorMessage({required dynamic exception}) {
    String message = 'undefine_error';

    if (exception is DioError) {


      if (exception.error is WebSocketException ||
          exception.error is HandshakeException) {
        message = 'error_internet_connection';
      } else if (exception.error is SocketException ||
          exception.error is TimeoutException ||
          exception.error is TimeoutException || exception.type == DioErrorType.connectTimeout) {
        message = 'error_internet_connection';
      }
      else if (exception.error is ApiException) {
        message = (exception.error as ApiException).message;
        print('handleApiError whenApiException is dio   $message');

      }
      else {
        message = 'undefine_error';
      }
    }

    if (exception is ApiException) {
      message = exception.message;
    }

    if (exception is SocketException) {
      // placeHolderImage = Image.asset(Res.connection_error);
      message = 'error_internet_connection';
    }

    if (exception is WebSocketException || exception is HandshakeException) {
      // placeHolderImage = Image.asset(Res.connection_error);
      message = 'check_network_connection';
    }

    return message;
  }

  ApiException handleApiError({required dynamic exception}) {
    String message = 'undefine_error';
    String code = "0";
    if (exception is DioError) {
      print('handleApiError is dio   ${exception.error is ApiException}');

      if (exception.error is WebSocketException ||
          exception.error is HandshakeException) {
        message = 'error_internet_connection';
      } else if (exception.error is SocketException ||
          exception.error is TimeoutException ||
          exception.error is TimeoutException || exception.type == DioErrorType.connectTimeout) {
        message = 'error_internet_connection';
      }
      else if (exception.error is ApiException) {
        message = (exception.error as ApiException).message;
        code = (exception.error as ApiException).code ;
      } else {
        message = 'undefine_error';
      }
    }

    if (exception is ApiException) {
      message = exception.message;
      code = exception.code;
    }

    if (exception is SocketException) {
      // placeHolderImage = Image.asset(Res.connection_error);
      message = 'error_internet_connection';
    }

    if (exception is WebSocketException || exception is HandshakeException) {
      // placeHolderImage = Image.asset(Res.connection_error);
      message = 'check_network_connection';
    }

    print('handleApiError message ${message}');
    return ApiException(message ,code );
  }


}

extension NullOrEmpty on String? {
  bool isNullOrEmpty() {
    return this == null || this!.trim().isEmpty ;
  }


}