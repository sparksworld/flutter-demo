import 'package:flutterdemo/module.dart';
import 'package:flutter_unionad/flutter_unionad.dart' as FlutterUnionad;

class CenterPage extends StatefulWidget {
  final Function callback;
  CenterPage({this.callback});

  @override
  State<StatefulWidget> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomHeaderDelegate(
                title: '哪吒之魔童降世',
                collapsedHeight: 40,
                expandedHeight: 300,
                paddingTop: MediaQuery.of(context).padding.top,
                coverImgUrl:
                    'https://img.zcool.cn/community/01c6615d3ae047a8012187f447cfef.jpg@1280w_1l_2o_100sh.jpg'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return FilmContent();
            }, childCount: 1),
          ),
        ],
      ),
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;
  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  void updateStatusBarBrightness(shrinkOffset) {
    if (shrinkOffset > 50 && this.statusBarMode == 'dark') {
      this.statusBarMode = 'light';
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ));
    } else if (shrinkOffset <= 50 && this.statusBarMode == 'light') {
      this.statusBarMode = 'dark';
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  void onChangeEvent(BuildContext context) async {
    if (Platform.isAndroid) {
      return showModalBottomSheet(
          context: context,
          isScrollControlled: true, //可滚动 解除showModalBottomSheet最大显示屏幕一半的限制
          shape: RoundedRectangleBorder(
            //圆角
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
          ),
          builder: (BuildContext context) {
            return AnimatedPadding(
              //showModalBottomSheet 键盘弹出时自适应
              padding: MediaQuery.of(context).viewInsets, //边距（必要）
              duration: const Duration(milliseconds: 100), //时常 （必要）
              child: Container(
                  // height: 180,
                  constraints: BoxConstraints(
                    minHeight: 90.0, //设置最小高度（必要）
                    maxHeight:
                        MediaQuery.of(context).size.height / 1.5, //设置最大高度（必要）
                  ),
                  padding: EdgeInsets.only(top: 34.0, bottom: 48.0),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30.0)),
                      color: Colors.white), //圆角
                  child: ScrollConfiguration(
                    behavior: OverScrollBehavior(),
                    child: ListView(
                      shrinkWrap: true, //防止状态溢出 自适应大小
                      children: <Widget>[
                        Wrap(
                          spacing: 2, //主轴上子控件的间距
                          runSpacing: 4, //交叉轴上子控件之间的间距

                          children: [
                            Center(
                              child: RaisedButton(
                                onPressed: () {
                                  SparkShare.usthWXSceneSession({
                                    'shareTitle': 'spark`极客笔录',
                                    'shareDesc': '极客笔录',
                                    'shareUrl': 'http://blog.fe-spark.cn',
                                    'shareThumbnail':
                                        'http://blog.fe-spark.cn/content/images/2019/07/timg--1----1-1.png'
                                  });
                                },
                                child: Text('图文分享(好友)'),
                              ),
                            ),
                            Center(
                              child: RaisedButton(
                                onPressed: () async {
                                  var a =
                                      (await SparkShare.checkAppInstalled())
                                          .toString();
                                  print('SparkShare --------> ' + a);
                                  SparkShare.usthWXSceneTimeline({
                                    'shareTitle': 'spark`极客笔录',
                                    'shareDesc': '极客笔录',
                                    'shareUrl': 'http://blog.fe-spark.cn',
                                    'shareThumbnail':
                                        'http://blog.fe-spark.cn/content/images/2019/07/timg--1----1-1.png'
                                  });
                                },
                                child: Text('图文分享(朋友圈)'),
                              ),
                            ),
                            Center(
                              child: RaisedButton(
                                onPressed: () {
                                  SparkShare.usthWXSceneSession({
                                    'shareTitle': "",
                                    'shareDesc': '',
                                    'shareUrl': '',
                                    'shareThumbnail':
                                        'http://blog.fe-spark.cn/content/images/2019/07/timg--1----1-1.png'
                                  });
                                },
                                child: Text('图片分享(好友)'),
                              ),
                            ),
                            Center(
                              child: RaisedButton(
                                onPressed: () {
                                  SparkShare.usthWXSceneTimeline({
                                    'shareTitle': '',
                                    'shareDesc': '',
                                    'shareUrl': '',
                                    'shareThumbnail':
                                        'http://blog.fe-spark.cn/content/images/2019/07/timg--1----1-1.png'
                                  });
                                },
                                child: Text('图片分享(朋友圈)'),
                              ),
                            ),
                            Center(
                              child: RaisedButton(
                                onPressed: () {
                                  SparkShare.usthWXSceneSessionWithText(
                                    'http://blog.fe-spark.cn/',
                                  );
                                },
                                child: Text('文字(好友)'),
                              ),
                            ),
                            Center(
                              child: RaisedButton(
                                onPressed: () {
                                  SparkShare.usthWXSceneTimelineWithText(
                                    'http://blog.fe-spark.cn/',
                                  );
                                },
                                child: Text('文字(朋友圈)'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            );
          });
    } else {
      Share.share('check out my website http://blog.fe-spark.cn');
    }

//    await SparkShare
    // print(await SparkShare.getAppInfoList());
    // print(await SparkShare.checkAppInstalled());
    // eventBus.fire(SwitchTab(0));
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    this.updateStatusBarBrightness(shrinkOffset);
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(child: Image.network(this.coverImgUrl, fit: BoxFit.cover)),
          Positioned(
            left: 0,
            top: this.maxExtent / 2,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000),
                    Color(0x90000000),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.arrow_back_ios,
                      //     color: this
                      //         .makeStickyHeaderTextColor(shrinkOffset, true),
                      //   ),
                      //   onPressed: () => Navigator.pop(context),
                      // ),
                      Container(
                        padding: EdgeInsets.only(left: 12.px),
                        child: Text(
                          this.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: this
                                .makeStickyHeaderTextColor(shrinkOffset, false),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: this
                              .makeStickyHeaderTextColor(shrinkOffset, true),
                        ),
                        onPressed: () => {onChangeEvent(context)},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilmContent extends StatelessWidget {
  get constraints => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await FlutterUnionad.loadRewardVideoAd(
                      mIsExpress: true, //是否个性化 选填
                      androidCodeId: "945565469", //Android 激励视频广告id  必填
                      iosCodeId: "945565469", //ios 激励视频广告id  必填
                      supportDeepLink: true, //是否支持 DeepLink 选填
                      rewardName: "100金币", //奖励名称 选填
                      rewardAmount: 1000, //奖励数量 选填
                      userID: "123", //  用户id 选填
                      orientation: FlutterUnionad.VideoVERTICAL, //视屏方向 选填
                      mediaExtra: null, //扩展参数 选填
                    );
                    // if (Platform.isAndroid) {
                    //   // SparkShare.usthWXSceneTimeline({
                    //   //   'shareTitle': Random().nextInt(10000000).toString(),
                    //   //   'shareDesc': '我是分享内容',
                    //   //   'shareUrl': 'http://blog.fe-spark.cn',
                    //   //   'shareThumbnail':
                    //   //       'http://blog.fe-spark.cn/content/images/2019/07/timg--1----1-1.png'
                    //   // });
                    // } else {
                    //   Share.share(
                    //       'check out my website http://blog.fe-spark.cn');
                    // }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      'https://img1.gamersky.com/image2019/07/20190725_ll_red_136_2/gamersky_07small_14_201972510258D0.jpg',
                      width: 130,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '哪吒之魔童降世',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        '动画/中国大陆/110分钟',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF999999),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 2)),
                      Text(
                        '2019-07-26 08:00 中国大陆上映',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF999999),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 2)),
                      Text(
                        '32.1万人想看/大V推荐度95%',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '剧情简介',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  '天地灵气孕育出一颗能量巨大的混元珠，元始天尊将混元珠提炼成灵珠和魔丸，灵珠投胎为人，助周伐纣时可堪大用；而魔丸则会诞出魔王，为祸人间。元始天尊启动了天劫咒语，3年后天雷将会降临，摧毁魔丸。太乙受命将灵珠托生于陈塘关李靖家的儿子哪吒身上。然而阴差阳错，灵珠和魔丸竟然被掉包。本应是灵珠英雄的哪吒却成了混世大魔王。调皮捣蛋顽劣不堪的哪吒却徒有一颗做英雄的心。然而面对众人对魔丸的误解和即将来临的天雷的降临，哪吒是否命中注定会立地成魔？他将何去何从？',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          //不显示头部水波纹
          showLeading: false,
          //不显示尾部水波纹
          showTrailing: false,
          axisDirection: axisDirection,
          color: Theme.of(context).accentColor,
        );
    }
    return null;
  }
}
