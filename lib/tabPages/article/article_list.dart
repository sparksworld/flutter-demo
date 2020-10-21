// import 'dart:math';
import 'package:flutterdemo/module.dart';
import 'package:flutter_unionad/flutter_unionad.dart' as FlutterUnionad;
import 'package:flutterdemo/tabPages/video/video_list_item.dart';
import 'article_list_item.dart';

class MinorArticlePage extends StatefulWidget {
  final Function callback;

  MinorArticlePage({Key key, this.callback}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MinorArticlePageState();
}

class _MinorArticlePageState extends State<MinorArticlePage>
    with AutomaticKeepAliveClientMixin {
  bool _loading;
  bool _finished;
  bool _error;
  ScrollController _controller;
  List listData = List();
  int start;

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
      }).then((data) async {
        List _data = data;
        setState(() {
          _error = false;
          _loading = false;

          if (start == 0) listData = List();
          listData += _data;
          start += _data.length;
          if (_data.length < 10) {
            _finished = true;
          }
        });
        return data;
      }).catchError((err) {
        print(err);
        setState(() {
          _loading = false;
          _finished = false;
          _error = true;
        });
      });
    }
  }

  @override
  void initState() {
    if (mounted) {
      _loading = false;
      _finished = false;
      _error = false;
      start = 0;
      _controller = ScrollController();
      this.getArticleList();
      _controller.addListener(() async {
        // print(_controller.offset);
        if (_controller.offset >= _controller.position.maxScrollExtent) {
          // await Future.delayed(new Duration(seconds: 1), () {
          this.getArticleList();
          // });
        }
      });
    }

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
    return new RefreshIndicator(
      displacement: 28.0.px,
      onRefresh: () => _handlerRefresh(),
      child: Scrollbar(
        child: _error
            ? Center(
                child: GestureDetector(
                  onTap: () => _handlerRefresh(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '网络错误',
                        style: TextStyle(
                          fontSize: 17.0.px,
                          color: Color(0xff999999),
                        ),
                      ),
                      Icon(
                        Icons.refresh,
                        color: Color(0xff999999),
                      )
                    ],
                  ),
                ),
              )
            : ((start == 0 && _loading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : new ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: listData.length + 1,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      if (listData.length == index) {
                        if (!_finished) {
                          if (_loading) {
                            return _buildFootView('加载中...');
                          } else {
                            return _buildFootView('上划继续加载...');
                          }
                        } else {
                          return _buildFootView('加载完成');
                        }
                      }
                      return index % 2 == 0
                          ? FlutterUnionad.nativeAdView(
                              androidCodeId:
                                  "945559988", //android banner广告id 必填
                              iosCodeId: "945559988", //ios banner广告id 必填
                              supportDeepLink: true, //是否支持 DeepLink 选填
                              expressViewWidth: 375, // 期望view 宽度 dp 必填
                              expressViewHeight: 168, //期望view高度 dp 必填
                              callBack:
                                  (FlutterUnionad.FlutterUnionadState state) {
                                //广告事件回调 选填
                                //广告事件回调 选填
                                //type onShow广告成功显示 onDislike不感兴趣 onFail广告加载失败
                                //params 详细说明
                                switch (state.type) {
                                  case FlutterUnionad.onShow:
                                    print(state.tojson());
                                    break;
                                  case FlutterUnionad.onFail:
                                    print(state.tojson());
                                    break;
                                  case FlutterUnionad.onDislike:
                                    print(state.tojson());
                                    break;
                                }
                              },
                            )
                          : listData[index].articleType == 1
                              ? ArticleListViewItem(
                                  key: Key(index.toString()),
                                  itemData: listData[index],
                                  callback: widget.callback,
                                )
                              : VideoListViewItem(
                                  key: Key(index.toString()),
                                  itemData: listData[index],
                                  callback: widget.callback,
                                );
                    },
                  )),
      ),
    );
  }

  Widget _buildFootView(String text) {
    return Container(
      child: Center(
          child: Padding(
        padding: EdgeInsets.all(24.0.px),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loading
                ? Container(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.all(24.0.px),
              child: Text(
                text,
                style: TextStyle(fontSize: 16.0.px),
              ),
            )
          ],
        ),
      )),
    );
  }

  Future<void> _handlerRefresh() async {
    //模拟耗时5秒
    await new Future.delayed(new Duration(seconds: 1), () {
      if (this.mounted) {
        setState(() {
          this.start = 0;
          this.getArticleList();
        });
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
