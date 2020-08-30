import 'package:flutter/material.dart';
import 'package:flutterdemo/component/header.dart';
import 'home_list.dart';

final _inputController = MyTextEditingController();

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: GestureDetector(
            onTap: () {
              // Navigator.of(context)
              // .push(CupertinoPageRoute(builder: (context) => SearchPage()));
            },
            child: Container(
              height: 45.0,
              child: Card(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.black87,
                      size: 20.0,
                    ),
                    Text(
                      "自助烤肉",
                      style: TextStyle(fontSize: 15.0, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.timer),
            onPressed: () {
              // showSearch(context: context, delegate: searchBarDelegate());
            },
          ),
          // PopupMenuButton(icon: ,)
        ],
      ),
      body: DefaultTabController(
        length: 9,
        child: Column(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                border: new Border(
                  bottom: BorderSide(color: Color(0xffE6E6FA), width: 0.5),
                  //  color:
                ),
                // 边色与边宽度
                color: Colors.white, // 底色
                //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                // borderRadius: new BorderRadius.vertical(
                //     top: Radius.elliptical(20, 50)), // 也可控件一边圆角大小
              ),
              // color: Colors.white,
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(bottom: 2.0),
                indicatorColor: Theme.of(context).primaryColor,
                isScrollable: true,
                // labelPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                unselectedLabelStyle:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                labelStyle:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                tabs: <Widget>[
                  Tab(text: '推荐'),
                  Tab(text: '资讯'),
                  Tab(text: '搞笑'),
                  Tab(text: '段子'),
                  Tab(text: '科技'),
                  Tab(text: '汽车'),
                  Tab(text: '医疗'),
                  Tab(text: '便民'),
                  Tab(text: '三农'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                children: <Widget>[
                  MinorHomePage(key: Key('1')),
                  MinorHomePage(key: Key('2')),
                  MinorHomePage(key: Key('3')),
                  MinorHomePage(key: Key('4')),
                  MinorHomePage(key: Key('5')),
                  MinorHomePage(key: Key('6')),
                  MinorHomePage(key: Key('7')),
                  MinorHomePage(key: Key('8')),
                  MinorHomePage(key: Key('9')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
