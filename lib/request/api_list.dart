import 'package:flutterdemo/models/index.dart';
// import 'dart:developer';
import 'package:dio/dio.dart';
import 'dio.dart';

class ApiList {
  static Dio http;
  ApiList() {
    Request();
    http = Request.dio;
  }
  // @override
  // void run() {
  //   // 调用父类的方法
  //   super.run();
  //   print("student running...");
  // }

  static getInitData(Map<String, dynamic> queryParameters) {
    return http
        .get('/qktx-content/task/getArticleRelationList',
            queryParameters: queryParameters)
        .then(
      (Response res) {
        if (res.data != null && res.data['result'] == 1) {
          return res.data['data'].map((e) => ListItem.fromJson(e)).toList();
        } else {
          return List();
        }
      },
    );
  }

  static getPostData(data) {
    FormData formData = FormData.fromMap(data);
    return http.post("/info", data: formData);
  }
}
