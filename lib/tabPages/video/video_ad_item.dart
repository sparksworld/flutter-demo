import 'package:flutterdemo/module.dart';
import 'package:flutter_unionad/flutter_unionad.dart' as FlutterUnionad;

class VideoAdItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideoAdItemState();
  }
}

class _VideoAdItemState extends State<VideoAdItem>
    with AutomaticKeepAliveClientMixin {
  bool _offstage = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Offstage(
      offstage: _offstage,
      child: FlutterUnionad.nativeAdView(
        androidCodeId: "945561901", //android banner广告id 必填
        iosCodeId: "945561901", //ios banner广告id 必填
        supportDeepLink: true, //是否支持 DeepLink 选填
        expressViewWidth: 375, // 期望view 宽度 dp 必填
        expressViewHeight: 284, //期望view高度 dp 必填
        callBack: (FlutterUnionad.FlutterUnionadState state) {
          //广告事件回调 选填
          //广告事件回调 选填
          //type onShow广告成功显示 onDislike不感兴趣 onFail广告加载失败
          //params 详细说明
          switch (state.type) {
            case FlutterUnionad.onShow:
              setState(() {
                _offstage = false;
              });
              print(state.tojson());
              break;
            case FlutterUnionad.onFail:
              setState(() {
                _offstage = true;
              });
              print(state.tojson());
              break;
            case FlutterUnionad.onDislike:
              print(state.tojson());
              break;
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
