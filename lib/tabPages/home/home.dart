// import 'package:flutter/material.dart';
import 'package:flutterdemo/module.dart';
import 'home_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List tabbars = [
    {'title': '推荐', 'typeKey': 0},
    {'title': '资讯', 'typeKey': 1},
    {'title': '搞笑', 'typeKey': 2},
    {'title': '段子', 'typeKey': 3},
    {'title': '科技', 'typeKey': 4},
    {'title': '汽车', 'typeKey': 5},
    {'title': '医疗', 'typeKey': 6},
    {'title': '便民', 'typeKey': 7},
    {'title': '三农', 'typeKey': 8},
  ];

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
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Card(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    color: Colors.grey[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.black87,
                          size: 20.0,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(24.0, 6.0, 0, 6.0),
                          child: Text(
                            "自助烤肉",
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.black87),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.timer),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                    // showSearch(context: context, delegate: searchBarDelegate());
                  },
                ),
              ],
            )),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.timer),
        //     onPressed: () {
        //       // showSearch(context: context, delegate: searchBarDelegate());
        //     },
        //   ),
        //   // PopupMenuButton(icon: ,)
        // ],
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
                labelColor: Theme.of(context).primaryColor,
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
                tabs: tabbars
                    .map((e) => Tab(
                          text: e['title'],
                        ))
                    .toList(),
              ),
            ),
            Expanded(
              flex: 1,
              child: TabBarView(
                children: List.generate(tabbars.length, (value) => value + 1)
                    .map(
                      (e) => MinorHomePage(
                        key: Key(e.toString()),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
