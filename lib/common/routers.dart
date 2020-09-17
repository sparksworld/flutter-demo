import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterdemo/models/index.dart';
import 'package:flutterdemo/routers/index.dart';

Map routeTable = {
  '/webview': {
    'page': (context, {arguments}) => WebViewExample(arguments: arguments),
    'needlogin': false
  },
  '/themeSetting': {
    'page': (context, {arguments}) => ThemeSetting(arguments: arguments),
    'needlogin': false
  },
  '/videoPlay': {
    'page': (context, {arguments}) => VideoPlay(arguments: arguments),
    'needlogin': false
  },
  '/articleDetail': {
    'page': (context, {arguments}) => ArticleDetail(arguments: arguments),
    'needlogin': false
  },
  '/setting': {
    'page': (context, {arguments}) => Setting(arguments: arguments),
    'needlogin': false
  },
  '/settingText': {
    'page': (context, {arguments}) => SettingTextPage(arguments: arguments),
    'needlogin': false
  }
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
  //把路由对象的name用变量保存
  final String name = settings.name;
  //保存路由对象对于的方法
  final Function pageContentBuilder = routeTable[name]['page'];
  print(pageContentBuilder);

  // User userinfo = Provider.of<UserModel>(context).user_info;
  // print(userinfo.toJson());
  //如果方法不为空
  if (!routeTable[name]['needlogin']) {
    if (settings.arguments != null) {
      return MaterialPageRoute(
        builder: (context) => pageContentBuilder(
          context,
          arguments: settings.arguments,
        ),
      );
      //放回路由组件对象
    } else {
      return MaterialPageRoute(
          builder: (context) => pageContentBuilder(context));
    }
  } else {
    return MaterialPageRoute(builder: (context) => LoginRoute());
  }
};
