import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/utils.dart';
import '../../exceptions/api_exception.dart';


class ClientCreator {
  final Interceptor? interceptor;
  ClientCreator({this.interceptor});
  Dio create() {
    final dio2 = Dio(); // Provide a dio instance
    dio2.options.connectTimeout = 60000 * 2;
    dio2.interceptors.add(LogInterceptor(responseBody: true));
    if (interceptor != null) {
      dio2.interceptors.add(interceptor!);
    }
    return dio2;
  }
}

class HeaderInterceptor extends Interceptor {
  final SUCCESS_CODE = 'success';
  final keyJson = "application/json";
  final keyAuthorization = "authorization";
  final keyApiKey = "apiKey";
  final apiKeyValue = "Nas@manpoweragent";
  final keyLanguage = "Language";

  final String accessToken;
  HeaderInterceptor({required this.accessToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[keyAuthorization] = 'Bearer $accessToken';
    options.headers[keyLanguage] = Get.locale!.languageCode.toString();
    options.headers[keyApiKey] = apiKeyValue;
    options.headers['platform'] = Platform.isAndroid ? 'Android' : 'IOS';

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        'DIO ERROR onError ${err.response != null} =>error message is  ${err.error}');

    if (err.response != null) {
      Map<String, dynamic> data = json.decode(err.response.toString());

      final message = data.containsKey('message') ? data['message'] : "Error";
      final status = data.containsKey('status') ? data['status'] : "Error";
      String code = data.containsKey('code') ? data['code'] : "E";
      /*throw DioError(
        error: message,
        response: err.response,
        type: DioErrorType.response,
        requestOptions: err.requestOptions,
      );*/
      throw ApiException(message, code);
    } else {
      super.onError(err, handler);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    Map<String, dynamic> data = response.data;
    final message = data.containsKey('message') ? data['message'] : "Error";
    final status = data.containsKey('status') ? data['status'] : "Error";
    String code = data.containsKey('code') ? response.data['code'] : "E";
    print('onRespons ${response.toString()} => ${code != 'Ok'}');
    if (status != SUCCESS_CODE) {
      throw ApiException(message, code);
    }
  }
}
