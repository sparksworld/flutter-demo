import 'dart:ui';

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
  void _showCardPopup(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {},
      barrierColor: Colors.grey.withOpacity(.4),
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: Opacity(
            opacity: anim1.value,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AlertDialog(
                    content: Container(
                      width: 300.0.px,
                      height: 300.0.px,
                      child: Image.network(
                          'https://img.ui.cn/data/file/9/4/0/3407049.gif'),
                    ),
                    elevation: 0,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    child: Center(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(this);
                      },
                      child: Image.network(
                        'https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/512x512/close.png',
                      ),
                    )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // print(Foo<String>().toString());
    if (mounted) {
      _bottomAppBarIndex = widget.tabActiveIndex != null
          ? widget.tabActiveIndex
          : _bottomAppBarIndex;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await new Future.delayed(new Duration(seconds: 2), () {
          _showCardPopup(context);
          TestOverLay.show(
            context: context,
            view: Container(
              child: CachedNetworkImage(
                width: 82.0.px,
                imageUrl: 'https://i.loli.net/2020/10/26/M3s4YfIVCeKPq2k.gif',
              ),
            ),
          );
        });
      });

      eventBus.on<SwitchTab>().listen((event) async {
        // print(event.runtimeType);
        setState(() {
          _bottomAppBarIndex = event.index;
        });
        // await new Future.delayed(new Duration(seconds: 2), () {
        //   _showCardPopup(context);
        // });
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
        body: Builder(
          builder: (context) {
            return OrientationBuilder(builder: (context, orientation) {
              return IndexedStack(
                index: _bottomAppBarIndex,
                children: [..._mainPageList],
              );
            });
          },
        ),
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
