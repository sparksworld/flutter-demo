import 'package:flutter/material.dart';
import 'package:flutterdemo/routers/index.dart';

final routes = {
  '/themeSetting': (context) => ThemeSetting(),
  '/videoPlay': (context) => VideoPlay(),
  '/articleDetail': (context) => ArticleDetail(),
  '/setting': (context) => Setting(),
  '/settingText': (context) => SettingTextPage(),
  '/login': (context) => LoginRoute(),
};

//固定写法
var onGenerateRoute = (settings) {
  // 统一处理
  //setting.isInitialRoute; bool类型 是否初始路由
  //setting.name; 要跳转的路由名key
  final String name = settings.name;
  //保存路由对象对于的方法
  final Function pageContentBuilder = routes[name];
  //如果方法不为空
  if (pageContentBuilder != null) {
    //如果有参数
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      //放回路由组件对象
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};

