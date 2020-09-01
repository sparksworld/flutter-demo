import 'package:flutter/material.dart';
import 'package:flutterdemo/mainPage/index.dart'
    show HomePage, VideoPage, MyPage, CenterPage, ActivityPage;
import "package:flutterdemo/event_bus/event_bus.dart";
import 'package:flutterdemo/states/index.dart';
import 'package:flutterdemo/common/appGlobal.dart';

// void main() => runApp(MyApp());
void main() async {
  await Global.init().then((e) {
    // Global.profile.theme = [11111];
    // Global.saveProfile();
    print(Colors.red.value);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // void _push(BuildContext context, Widget widget) {
  //   Navigator.push(context,
  //       new MaterialPageRoute(builder: (BuildContext context) {
  //     return widget;
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        title: "MaterialApp",
        // routes: {},
        home: MyHome(
          title: 'MaterialApp',
        ));
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

  void changeTab(index) {
    setState(() {
      _bottomAppBarIndex = index;
    });
  }

  void searchBarDelegate() {}
  @override
  Widget build(BuildContext context) {
    // _mainPageList[_bottomAppBarIndex]
    return Scaffold(
        body: IndexedStack(
          index: _bottomAppBarIndex,
          children: [..._mainPageList],
        ),
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
