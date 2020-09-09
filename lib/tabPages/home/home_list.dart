// import 'dart:math';

import 'package:flutterdemo/module.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'home_list_item.dart';
// import 'dart:developer';
// import 'package:flutterdemo/component/refresh_list_view.dart';
// List<String> _titles = ['湖人', '勇士', '雄鹿', '快船', '凯尔特人', '马刺', '76人', '猛龙'];
// TabController _tabController;

class MinorHomePage extends StatefulWidget {
  final Function callback;

  MinorHomePage({Key key, this.callback}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MinorHomePageState();
}

class _MinorHomePageState extends State<MinorHomePage>
    with AutomaticKeepAliveClientMixin {
  bool _loading = false;
  bool _showBottomLoading = true;
  // ScrollController _controller = ScrollController();
  EasyRefreshController _controller = EasyRefreshController();
  List listData = List();
  int start = 0;

  // Widget createListItem(index, data) {
  //   return ListViewItem(Key(index.toString()), data);
  // }

  Future getArticleList() async {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
      return ApiList.getInitData({
        'taskId': 11728664,
        'os': 1,
        'articleType': 1,
        'token': '',
        'start': start
      }).then((data) {
        setState(() {
          _loading = false;
          _showBottomLoading = false;
          List _data = data;
          if (start == 0) listData = _data;
          listData += _data;
          start += _data.length;
        });
        return data;
      });
    }
  }

  @override
  void initState() {
    this.getArticleList();
    // _controller?.addListener(() async {
    //   // print(_controller.offset);
    //   if (_controller.offset >= _controller.position.maxScrollExtent - 50) {
    //     setState(() {
    //       _showBottomLoading = true;
    //       this.getArticleList();
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scrollbar(
      child: EasyRefresh.custom(
        enableControlFinishRefresh: false,
        enableControlFinishLoad: true,
        controller: _controller,
        header: BezierHourGlassHeader(
          // color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(.5),
        ),
        footer: BezierBounceFooter(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(.5),
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            setState(() {
              this.start = 0;
              this.getArticleList();
            });

            _controller.resetLoadState();
          });
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 2), () {
            this.getArticleList();
            _controller.finishLoad(noMore: false);
          });
        },
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return HomeListViewItem(
                  key: Key(index.toString()),
                  index: index,
                  length: listData.length,
                  loading: _showBottomLoading,
                  itemData: listData[index],
                  callback: widget.callback,
                );
              },
              childCount: listData.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
