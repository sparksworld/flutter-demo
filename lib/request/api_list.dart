import 'package:dio/dio.dart';

import 'dio.dart';

class ApiList extends Request {
  Dio http;
  ApiList() : super() {
    this.http = super.dio;
  }

  getInitData() {
    return this.http.get('/com');
  }
}
