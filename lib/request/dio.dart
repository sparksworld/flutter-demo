import 'package:dio/dio.dart';
import 'package:flutterdemo/module.dart';
import 'dart:developer';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print(options.uri);
    print("REQUEST[${options?.method}] => PATH: ${options?.path}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print(
        "RESPONSE[${response?.statusCode}] => PATH: ${response?.request?.path}");
    log(response.toString());

    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    return super.onError(err);
  }
}

class Request {
  static Dio dio;
  BaseOptions options = new BaseOptions(
    baseUrl: "http://appv8.qukantianxia.com",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Request() {
    dio = new Dio(this.options);
    dio.interceptors.add(CustomInterceptors());
  }
}
