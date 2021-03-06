import 'package:flutterdemo/module.dart';
import 'package:flutterdemo/common/index.dart';
import 'package:flutterdemo/splash.dart';
// import 'package:pangolin/pangolin.dart' as Pangolin;
// import 'package:flutterdemo/tabPages/index.dart';
//import 'package:spark_share/spark_share.dart';
// import 'package:flutterdemo/routers/index.dart';

// import 'package:flutterdemo/routers/theme.dart';
// import 'package:flutterdemo/routers/detail.dart';
// import 'package:flutterdemo/routers/setting.dart';
// import 'package:flutterdemo/routers/settingText.dart';
// import 'package:flutterdemo/routers/login.dart';
Map routeTable = {
  '/webview': {
    'page': (context, {arguments}) => WebViewPage(arguments: arguments),
    'needlogin': true
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
  },
  '/login': {
    'page': (context, {arguments}) => LoginRoute(arguments: arguments),
    'needlogin': false
  },
  // '/in_app_webview': {
  //   'page': (context, {arguments}) => InAppWebViewPage(),
  //   'needlogin': false
  // }
};

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
// void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  await Permission.microphone.request();
  await SparkShare.initShare(
    """[{\"appName\":\"QQ\",\"downloadUrl\":\"\",\"optional\":1,\"packageName\":\"com.tencent.mobileqq\",\"appId\":\"wxf0a80d0ac2e82aa7\",\"type\":1},
    {\"appName\":\"qktx\",\"downloadUrl\":\"\",\"optional\":1,\"packageName\":\"com.yanhui.qktx\",\"appId\":\"wx1d2c2878b180942c\",\"type\":1}]""",
  );
  // await UsthSparkShare.checkAppInstalled();
  // await FlutterDownloader.initialize(
  //   debug: true, // optional: set false to disable printing logs to console
  // );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then((_) async {
    await Global.init().then((e) async {
      // await Future.delayed(Duration(days: 1));
      runApp(
        MyApp(),
      );
    });
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    // _showCardPopup(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TestChange()),
        ChangeNotifierProvider(create: (context) => ThemeModel()),
        ChangeNotifierProvider(create: (context) => UserModel()),
        // ChangeNotifierProvider(create: (context) => ThemeModel()),
      ],
      child: Consumer3<ThemeModel, TestChange, UserModel>(
        builder: (BuildContext context, themeModel, testChange, userModel,
            Widget child) {
          return MaterialApp(
            title: "悦读",
            navigatorKey: navigatorKey,
            theme: ThemeData(
              primaryIconTheme: IconThemeData(color: Colors.white),
              // buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              // iconTheme: IconThemeData(color: Colors.red),
              primarySwatch: createMaterialColor(themeModel.theme),
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              }),
            ),
            // routes: routeTable,
            onGenerateRoute: (RouteSettings settings) {
              //把路由对象的name用变量保存
              final String name = settings.name;
              //保存路由对象对于的方法
              final Function pageContentBuilder = routeTable[name]['page'];
              print(pageContentBuilder);

              User userinfo = Provider.of<UserModel>(context).userInfo;
              print(userinfo?.token);
              //如果方法不为空
              if (userinfo?.token == null && routeTable[name]['needlogin']) {
                return MaterialPageRoute(builder: (context) => LoginRoute());
              } else {
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
              }
            },
// MyHome(
//               title: '悦读',
//             )
            home: SplashScreen(),
            builder: (context, widget) {
              return MediaQuery(
                //设置文字大小不随系统设置改变
                data: MediaQuery.of(context)
                    .copyWith(textScaleFactor: testChange.textScaleFactor),
                child: widget,
              );
            },
          );
        },
      ),
    );
  }
}
