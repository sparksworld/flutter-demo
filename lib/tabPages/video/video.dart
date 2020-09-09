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
    MediaQueryData mediaQueryData = MediaQuery.of(context);
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
    return DefaultTabController(
      length: 9,
      child: Flex(
        direction: Axis.vertical,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: mediaQueryData.size.width,
            height: mediaQueryData.padding.top,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            flex: 1,
            child: Flex(
              direction: Axis.vertical,
              // mainAxisAlignment: MainAxisAlignment.start,
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
                    children:
                        List.generate(tabbars.length, (value) => value + 1)
                            .map(
                              (e) => MinorVideoPage(
                                key: Key(e.toString()),
                              ),
                            )
                            .toList(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
    // return Column(
    //   children: [
    //     // Container(
    //     //   width: mediaQueryData.size.width,
    //     //   height: mediaQueryData.padding.top,
    //     //   color: Theme.of(context).primaryColor,
    //     // ),
    //     Expanded(

    //     )
    //   ],
    // );
  }
}
