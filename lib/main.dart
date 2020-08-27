import 'package:flutter/material.dart';
import 'package:flutterdemo/mainPage/home.dart';
import 'package:flutterdemo/mainPage/my.dart';
import 'package:flutterdemo/mainPage/center.dart';
import 'package:flutterdemo/mainPage/activity.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void _push(BuildContext context, Widget widget) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red),
      title: "MaterialApp",
      home: MyHome(
        title: 'MaterialApp',
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
    _mainPageList
      ..add(HomePage(
        callback: (val) => changeTab(val),
      ))
      ..add(CenterPage(
        callback: (val) => changeTab(val),
      ))
      ..add(Activity(
        callback: (val) => changeTab(val),
      ))
      ..add(CenterPage(
        callback: (val) => changeTab(val),
      ))
      ..add(MyPage());
    super.initState();
  }

  void changeTab(index) {
    setState(() {
      _bottomAppBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _mainPageList[_bottomAppBarIndex],
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Container(
              // padding: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  bottomIcon(text: '首页', icon: Icons.home, index: 0),
                  bottomIcon(text: '首页', icon: Icons.add, index: 1),
                  bottomIcon(text: '', icon: Icons.access_time, index: -99),
                  bottomIcon(text: '首页', icon: Icons.add, index: 3),
                  bottomIcon(text: '首页', icon: Icons.person, index: 4),
                ],
              ),
            )),
        // body: ,
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
                  color: Colors.white,
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

// class SwitchTabBar extends StatefulWidget{
//   Widget page;
//   final eventData;
//   final Function callback;

//   SwitchTabBar(this.page,{this.eventData, this.callback});

//   @override
//   State <StatefulWidget> createState() {
//     return SwitchTabBarState();
//   }
// }

// class SwitchTabBarState extends State<SwitchTabBar> {
//   @override
//   Widget build(BuildContext context) {
//     return widget.page;
//   }
// }
