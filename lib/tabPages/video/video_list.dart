import 'package:flutterdemo/module.dart';
import 'video_list_item.dart';
import 'dart:developer';

class MinorVideoPage extends StatefulWidget {
  final Function callback;

  MinorVideoPage({Key key, this.callback}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MinorVideoPageState();
}

class _MinorVideoPageState extends State<MinorVideoPage>
    with AutomaticKeepAliveClientMixin<MinorVideoPage> {
  bool _loading;
  bool _finished;
  bool _error;
  ScrollController _controller;
  List listData;
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
        _error = false;
        await new Future.delayed(Duration(seconds: 3), () {
          setState(() {
            _loading = false;
            if (start == 0) listData = _data;
            listData += _data;
            start += _data.length;
            if (_data.length < 10) {
              _finished = true;
            }
          });
        });
        return data;
      }).catchError((err) {
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
      listData = List();
      start = 0;
      _controller = ScrollController();
      this.getArticleList();
      _controller.addListener(() async {
        // print(_controller.offset);
        if (_controller.offset >= _controller.position.maxScrollExtent) {
          await Future.delayed(new Duration(seconds: 1), () {
            setState(() {
              this.getArticleList();
            });
          });
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
    return Container(
      color: Color(0xfff5f5f5),
      child: new RefreshIndicator(
        displacement: 28.0.px,
        onRefresh: () => _handlerRefresh(),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
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
                          return VideoListViewItem(
                            key: Key(index.toString()),
                            // index: index,
                            // length: listData.length,
                            // loading: _showBottomLoading,
                            itemData: listData[index],
                            callback: widget.callback,
                          );
                        },
                      )),
          ),
        ),
      ),
    );
  }

  Widget _buildFootView(String text) {
    return Container(
      child: Center(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loading
                ? Container(
                    width: 14,
                    height: 14,
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
