import 'package:flutter/material.dart';
import 'package:flutterdemo/mock/home.dart';
import 'package:flutterdemo/component/list_view_item.dart';
// import 'package:flutterdemo/component/refresh_list_view.dart';
// List<String> _titles = ['湖人', '勇士', '雄鹿', '快船', '凯尔特人', '马刺', '76人', '猛龙'];
// TabController _tabController;

class HomePage extends StatefulWidget {
  final Function callback;

  HomePage({this.callback});
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;
  ScrollController _controller = ScrollController();
  List<Article> listData = postData;

  // Widget createListItem(index, data) {
  //   return ListViewItem(Key(index.toString()), data);
  // }

  //获取列表数据
  // Future<List> getListData([Map<String, dynamic> params]) async {
  //   dynamic testElement = params.values.elementAt(0);
  //   for (int i = 0; i < listData.length; i++) {
  //     listData[i] = listData[i] + testElement.toString();
  //   }
  //   return listData;
  // }
  @override
  void initState() {
    _controller.addListener(() async {
      // print(_controller.offset);
      if (_controller.offset >= _controller.position.maxScrollExtent - 50) {
        if (!_loading) {
          setState(() {
            _loading = true;
          });
          await new Future.delayed(new Duration(seconds: 2));
          print(_controller.position.maxScrollExtent);
          setState(() {
            listData += postData;
            _loading = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      displacement: 28.0,
      child: new ListView.builder(
        itemBuilder: (context, index) {
          return ListViewItem(
            index: index,
            length: listData.length,
            loading: _loading,
            itemData: listData[index],
            callback: widget.callback,
          );
        },
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: listData.length,
        controller: _controller,
      ),
      //刷新方法
      onRefresh: () => _handlerRefresh(),
    );
  }

  Future<void> _handlerRefresh() async {
    //模拟耗时5秒
    await new Future.delayed(new Duration(seconds: 2));
    setState(() {
      listData = postData;
    });
  }
}
