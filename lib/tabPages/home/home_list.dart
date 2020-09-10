// import 'dart:math';
import 'package:flutterdemo/module.dart';
import 'home_list_item.dart';

class MinorHomePage extends StatefulWidget {
  final Function callback;

  MinorHomePage({Key key, this.callback}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MinorHomePageState();
}

class _MinorHomePageState extends State<MinorHomePage>
    with AutomaticKeepAliveClientMixin {
  bool _loading = false;
  bool _finished = false;
  ScrollController _controller = ScrollController();
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
          if (start == 0) listData = _data;
          listData += _data;
          start += _data.length;
          if (_data.length < 10) {
            _finished = true;
          }
        });
        return data;
      }).catchError((err) {
        _loading = false;
        print(err);
      });
    }
  }

  @override
  void initState() {
    this.getArticleList();
    _controller?.addListener(() async {
      // print(_controller.offset);
      if (_controller.offset >= _controller.position.maxScrollExtent) {
        await Future.delayed(new Duration(seconds: 1), () {
          setState(() {
            this.getArticleList();
          });
        });
      }
    });
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
        child: (start == 0 && _loading)
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
                        return _buildFootView('loading...');
                      } else {
                        return _buildFootView('come on....');
                      }
                    } else {
                      return _buildFootView('finished...');
                    }
                  }
                  return HomeListViewItem(
                    key: Key(index.toString()),
                    // index: index,
                    // length: listData.length,
                    // loading: _showBottomLoading,
                    itemData: listData[index],
                    callback: widget.callback,
                  );
                },
              ),
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
              padding: EdgeInsets.only(left: 10),
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
