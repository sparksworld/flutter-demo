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
  static Future getUserInfo(data) {
    print(DateTime.now().second);
    if (data["username"] != null && data["password"] != null) {
      return Future.delayed(Duration(seconds: 2), () {
        return User.fromJson({
          "username": data["username"],
          "gender": "",
          "age": "",
          "token": DateTime.now().millisecondsSinceEpoch.toString()
          // "permissions": {}
        });
      });
    }
  }

  static Future getInitData(Map<String, dynamic> data) {
    return http
        .get('/qktx-content/task/getArticleRelationList', queryParameters: data)
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

