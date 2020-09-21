import 'package:flutterdemo/module.dart';
import 'package:flutterdemo/tabPages/index.dart'
    show HomePage, VideoPage, MyPage, CenterPage, ActivityPage;
import 'package:flutterdemo/common/index.dart';
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
  '/in_app_webview': {
    'page': (context, {arguments}) => InAppWebViewPage(),
    'needlogin': false
  }
};

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
// void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  await Permission.microphone.request();
  // await FlutterDownloader.initialize(
  //   debug: true, // optional: set false to disable printing logs to console
  // );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then((_) async {
    await Global.init().then((e) async {
      runApp(
        MyApp(),
      );
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            navigatorKey: navigatorKey,
            theme: ThemeData(
              // primaryIconTheme: IconThemeData(color: Colors.red),
              primarySwatch: createMaterialColor(themeModel.theme),
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              }),
            ),
            title: "MaterialApp",
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

            home: MyHome(
              title: 'MaterialApp',
            ),
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

class MyHome extends StatefulWidget {
  final int tabActiveIndex;
  final String title;

  MyHome({Key key, this.title, this.tabActiveIndex}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _bottomAppBarIndex = 0;
  List<dynamic> _mainPageList = [];
  @override
  void initState() {
    // print(Foo<String>().toString());
    if (mounted) {
      _bottomAppBarIndex = widget.tabActiveIndex != null
          ? widget.tabActiveIndex
          : _bottomAppBarIndex;
      eventBus.on<SwitchTab>().listen((event) async {
        // print(event.runtimeType);
        setState(() {
          _bottomAppBarIndex = event.index;
        });
        // await new Future.delayed(new Duration(seconds: 2));
        // setState(() {
        //   _bottomAppBarIndex = 0;
        // });
      });
      _mainPageList = [
        HomePage(),
        VideoPage(),
        ActivityPage(),
        CenterPage(),
        MyPage()
      ];
      super.initState();
    }
  }

  void changeTab(index) {
    setState(() {
      _bottomAppBarIndex = index;
    });
  }

  void searchBarDelegate() {}

  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize(context);
    // _mainPageList[_bottomAppBarIndex]
    return Scaffold(
        body: OrientationBuilder(builder: (context, orientation) {
          // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
          return IndexedStack(
            index: _bottomAppBarIndex,
            children: [..._mainPageList],
          );
        }),
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Container(
              // padding: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  bottomIcon(text: '资讯', icon: Icons.home, index: 0),
                  bottomIcon(text: '视频', icon: Icons.movie_filter, index: 1),
                  bottomIcon(text: '', icon: Icons.access_time, index: -99),
                  bottomIcon(text: '任务', icon: Icons.blur_on, index: 3),
                  bottomIcon(text: '我的', icon: Icons.person, index: 4),
                ],
              ),
            )),
        // body: ,
        resizeToAvoidBottomPadding: false,
        floatingActionButton: FloatingActionButton(
          // shape: const CircleBorder(),
          elevation: 0.0,
          highlightElevation: 0.0,
          splashColor: Colors.transparent,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.access_time),
          onPressed: () {
            setState(() {
              _bottomAppBarIndex = 2;
            });
          },
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Widget bottomIcon({IconData icon, int index, String text}) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _bottomAppBarIndex = index;
          });
        },
        child: SizedBox(
          height: 54.0,
          width: double.infinity,
          child: text.isNotEmpty
              ? Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: _bottomAppBarIndex == index
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      Text(
                        text,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: _bottomAppBarIndex == index
                                ? Theme.of(context).primaryColor
                                : Colors.grey),
                      ),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
