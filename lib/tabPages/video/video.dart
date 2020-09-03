import 'package:flutterdemo/module.dart';
import 'video_list.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoPageState();
  }
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: DefaultTabController(
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
                    MinorVideoPage(key: Key('1')),
                    MinorVideoPage(key: Key('2')),
                    MinorVideoPage(key: Key('3')),
                    MinorVideoPage(key: Key('4')),
                    MinorVideoPage(key: Key('5')),
                    MinorVideoPage(key: Key('6')),
                    MinorVideoPage(key: Key('7')),
                    MinorVideoPage(key: Key('8')),
                    MinorVideoPage(key: Key('9')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
