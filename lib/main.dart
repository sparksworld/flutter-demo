import 'package:flutterdemo/module.dart';
import 'package:flutterdemo/tabPages/index.dart'
    show HomePage, VideoPage, MyPage, CenterPage, ActivityPage;
import 'package:flutterdemo/common/index.dart';
import 'package:flutterdemo/routers/index.dart';
// import 'package:flutterdemo/routers/theme.dart';
// import 'package:flutterdemo/routers/detail.dart';
// import 'package:flutterdemo/routers/setting.dart';
// import 'package:flutterdemo/routers/settingText.dart';
// import 'package:flutterdemo/routers/login.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
// void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await Global.init().then((e) {
      runApp(MyApp());
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
        // ChangeNotifierProvider(create: (context) => ThemeModel()),
      ],
      child: Consumer2<ThemeModel, TestChange>(
        builder: (BuildContext context, themeModel, testChange, Widget child) {
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
            routes: {
              '/themeSetting': (context) => ThemeSetting(),
              '/videoPlay': (context) => VideoPlay(),
              '/articleDetail': (context) => ArticleDetail(),
              '/setting': (context) => Setting(),
              '/settingText': (context) => SettingTextPage(),
              '/login': (context) => LoginRoute(),
            },
            // onGenerateRoute: onGenerateRoute,
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
  final String title;

  MyHome({Key key, this.title}) : super(key: key);

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
