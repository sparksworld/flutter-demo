// import 'package:flutter/material.dart';
import 'package:flutterdemo/module.dart';
import 'article_list.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ArticlePageState();
  }
}

class _ArticlePageState extends State<ArticlePage> {
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

  List _shuffling = [
    "一少女惨遭八名壮汉轮流让座",
    "一少女惨遭八名壮汉轮流让座",
    "一少女惨遭八名壮汉轮流让座",
    "一少女惨遭八名壮汉轮流让座",
    "一少女惨遭八名壮汉轮流让座"
  ];
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();

    timer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void timer() {
    new Timer.periodic(Duration(milliseconds: 3000), (timer) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8.0.px,
        centerTitle: false,
        title: GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, '/search');
            showSearch(context: context, delegate: SearchBar());
            // .push(CupertinoPageRoute(builder: (context) => SearchPage()));
          },
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                        color: Color(0xFFEFEFEF),
                        width: 0.5,
                      ), // 边色与边宽度
                      color: Colors.white, // 底色
                      borderRadius: new BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    height: 40.0.px,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8.0.px),
                          child: Icon(
                            Icons.search,
                            color:
                                Theme.of(context).primaryColor.withOpacity(.75),
                          ),
                        ),
                        SizedBox(
                          width: 200.0.px,
                          height: 40.0.px,
                          child: PageView(
                            controller: _pageController,
                            scrollDirection: Axis.vertical,
                            onPageChanged: (int index) {
                              if (index == _shuffling.length - 1) {
                                Future.delayed(
                                  Duration(milliseconds: 1000),
                                  () {
                                    _pageController.jumpToPage(0);
                                  },
                                );
                              }
                            },
                            children: _shuffling
                                .map(
                                  (e) => Center(
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.75),
                                          fontSize: 14.0.px),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.0.px),
                child: IconButton(
                  icon: Icon(Icons.timer),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                    // showSearch(context: context, delegate: searchBarDelegate());
                  },
                ),
              )
            ],
          ),
        ),
      ),
      body: Builder(builder: (context) {
        // TestOverLay.show(
        //   context: context,
        //   view: Container(
        //     key: GlobalKey(),
        //     child: CachedNetworkImage(
        //       width: 82.0.px,
        //       imageUrl: 'https://i.loli.net/2020/10/26/M3s4YfIVCeKPq2k.gif',
        //     ),
        //   ),
        // );
        return Stack(
          children: [
            DefaultTabController(
              length: 9,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      border: new Border(
                        bottom:
                            BorderSide(color: Color(0xffE6E6FA), width: 0.5),
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
                                (e) => MinorArticlePage(
                                  key: Key(e.toString()),
                                ),
                              )
                              .toList(),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 12.0.px,
              right: 12.0.px,
              child: GestureDetector(
                onTap: () {
                  launch(
                    'https://github.com/sparksworld/flutter-demo',
                  );
                },
                child: Image.network(
                  'https://i.loli.net/2020/10/26/M3s4YfIVCeKPq2k.gif',
                  width: 82.0,
                  height: 82.0,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class SearchBar extends SearchDelegate<String> {
  // 点击清楚的方法
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        // 点击把文本空的内容清空
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  // 点击箭头返回
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        // 使用动画效果返回
        icon: AnimatedIcons.menu_arrow, progress: transitionAnimation,
      ),
      // 点击的时候关闭页面（上下文）
      onPressed: () {
        close(context, null);
      },
    );
  }

  // 点击搜索出现结果
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Card(
        color: Colors.pink,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  // 搜索下拉框提示的方法
  @override
  Widget buildSuggestions(BuildContext context) {
    // 定义变量 并进行判断
    final suggestionList = [];
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: RichText(
                  text: TextSpan(
                      // 获取搜索框内输入的字符串，设置它的颜色并让让加粗
                      text: suggestionList[index].substring(0, query.length),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                TextSpan(
                    //获取剩下的字符串，并让它变成灰色
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ])));
        });
  }
}
