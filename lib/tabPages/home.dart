import 'package:flutterdemo/module.dart';

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
  DateTime lastPopTime;

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
        ArticlePage(),
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
    return WillPopScope(
      onWillPop: () async {
        if (lastPopTime == null ||
            DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
          lastPopTime = DateTime.now();

          Fluttertoast.showToast(
              msg: '再次点击返回退出应用', gravity: ToastGravity.CENTER);
        } else {
          lastPopTime = DateTime.now();
          Fluttertoast.cancel().then((value) async => await SystemChannels
              .platform
              .invokeMethod('SystemNavigator.pop'));
          // await ;
        }
      },
      child: Scaffold(
        body: OrientationBuilder(builder: (context, orientation) {
          return IndexedStack(
            index: _bottomAppBarIndex,
            children: [..._mainPageList],
          );
        }),
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Container(
              color: Colors.transparent,
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
        floatingActionButton: FloatingActionButton(
          // shape: const CircleBorder(),
          elevation: 1.0,
          highlightElevation: 0.0,
          splashColor: Colors.transparent,
          // backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.access_time,
            color: Theme.of(context).primaryIconTheme.color,
          ),
          onPressed: () {
            setState(() {
              _bottomAppBarIndex = 2;
            });
            return false;
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget bottomIcon({IconData icon, int index, String text}) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _bottomAppBarIndex = index;
          });
          return false;
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
              : Container(
                  color: Colors.transparent,
                ),
        ),
      ),
    );
  }
}
