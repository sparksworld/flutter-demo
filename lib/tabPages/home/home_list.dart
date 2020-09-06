import 'package:flutterdemo/module.dart';
import 'package:flutterdemo/mock/article.dart';
import 'home_list_item.dart';
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
    with AutomaticKeepAliveClientMixin<MinorHomePage> {
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
    dio.get('http://www.baidu.com').then((value) {
      print(value);
      // setState(() {
        
      // });
    });
    _controller?.addListener(() async {
      // print(_controller.offset);
      if (_controller.offset >= _controller.position.maxScrollExtent - 50) {
        if (!_loading) {
          if (this.mounted) {
            setState(() {
              _loading = true;
            });
          }
          await new Future.delayed(new Duration(milliseconds: 500));
          if (this.mounted) {
            setState(() {
              listData += postData;
              _loading = false;
            });
          }
        }
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
      displacement: 28.0,
      onRefresh: () => _handlerRefresh(),
      child: Scrollbar(
        child: new ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: listData.length,
          controller: _controller,
          itemBuilder: (context, index) {
            return HomeListViewItem(
              // key: Key(index.toString()),
              index: index,
              length: listData.length,
              loading: _loading,
              itemData: listData[index],
              callback: widget.callback,
            );
          },
        ),
      ),
    );
  }

  Future<void> _handlerRefresh() async {
    //模拟耗时5秒
    await new Future.delayed(new Duration(seconds: 5));
    if (this.mounted) {
      setState(() {
        listData = postData;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
