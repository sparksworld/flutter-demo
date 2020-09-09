import 'package:flutterdemo/module.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
// import 'package:flutter_easyrefresh/bezier_circle_header.dart';
// import 'package:flutter_easyrefresh/material_header.dart';
// import 'package:flutter_easyrefresh/material_footer.dart';
import 'video_list_item.dart';

class MinorVideoPage extends StatefulWidget {
  final Function callback;

  MinorVideoPage({Key key, this.callback}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MinorVideoPageState();
}

class _MinorVideoPageState extends State<MinorVideoPage>
    with AutomaticKeepAliveClientMixin<MinorVideoPage> {
  bool _loading = false;
  bool _showBottomLoading = true;
  EasyRefreshController _controller = EasyRefreshController();
  // ScrollController _controller = ScrollController();
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
        List _data = data;
        setState(() {
          _loading = false;
          _showBottomLoading = false;
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
          backgroundColor: Theme.of(context).primaryColor
        ),
        footer: BezierBounceFooter(
          backgroundColor: Theme.of(context).primaryColor,
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
                return VideoListViewItem(
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
