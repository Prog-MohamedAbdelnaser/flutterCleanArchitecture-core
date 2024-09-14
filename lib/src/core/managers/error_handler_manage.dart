

import 'dart:io';

import 'package:dio/dio.dart';

import '../../../main_index.dart';
import '../exceptions/api_exception.dart';
import '../exceptions/app_base_exception.dart';
import 'app_error.dart';
import 'error_handler.dart';

class DefaultErrorHandler extends ErrorHandler{

  DefaultErrorHandler._internal(); // Private constructor for singleton

  static final DefaultErrorHandler _instance = DefaultErrorHandler._internal();

  static DefaultErrorHandler get instance => _instance;

  AppError prepareError(dynamic exception) {
    var title = '';
    var msg = undefineError();
    switch (exception) {
      case DioException():
        {
          return appErrorFromDioError(exception);
        }
      case AppBaseException():
        {
          return appErrorFromAppBaseException(exception);
        }
      case Exception():
        {
          return AppError(
              title: title,
              message: exception.toString(),
              errorType: ErrorType.Unknown);
        }
      case const (String):
        {
          return AppError(
              title: title,
              message: exception,
              errorType: ErrorType.Unknown);
        }
      default:
        {
          return AppError(
              title: title,
              message: msg,
              errorType: ErrorType.Unknown);
        }
    }
  }

  AppError appErrorFromAppBaseException(AppBaseException exception) {
    return AppError(
        errorType: exception.errorType,
        message: exception.toLocalize(getLanguageCode()));

  }

  AppError appErrorFromDioError(DioException dioError) {
    var msg = undefineError();

    final error = dioError.error;

    switch (error) {
      case WebSocketException():
      case HandshakeException():
      case SocketException():
        {
          return AppError(
              message:noConnectionMessage(),
              errorType: ErrorType.Timeout);
        }
      case ApiException():
        {
         return AppError(
              message: error.message,
              errorType: ErrorType.Data);
        }
      case AppBaseException():
        {
          return appErrorFromAppBaseException(error);
        }
      default:
        {
          return AppError(
              errorType: ErrorType.Unknown,
              message: dioError.message ?? msg,);
        }
    }
  }


  String noConnectionMessage() {
    return 'No Connection';
  }

  String undefineError() {
    return 'undefine Error';
  }

  @override
  String getLanguageCode() {
    return 'en';
  }
}
