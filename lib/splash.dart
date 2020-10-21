import 'package:flutterdemo/module.dart';
import 'package:flutter_unionad/flutter_unionad.dart' as FlutterUnionad;
// import 'package:pangolin/pangolin.dart' as Pangolin;

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  void navigationPage() {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 0), //动画时间为500毫秒
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return new FadeTransition(
            //使用渐隐渐入过渡,
            opacity: animation,
            child: MyHome(tabActiveIndex: 0), //路由B
          );
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  _initFlutterUnionad() async {
    await FlutterUnionad.register(
        androidAppId: "5113549", //穿山甲广告 Android appid 必填
        iosAppId: "5113549", //穿山甲广告 ios appid 必填
        useTextureView:
            true, //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView 选填
        appName: "悦读", //appname 必填
        allowShowNotify: true, //是否允许sdk展示通知栏提示 选填
        allowShowPageWhenScreenLock: true, //是否在锁屏场景支持展示广告落地页 选填
        debug: true, //测试阶段打开，可以通过日志排查问题，上线时去除该调用 选太难
        supportMultiProcess: true, //是否支持多进程，true支持 选填
        directDownloadNetworkType: [
          FlutterUnionad.NETWORK_STATE_2G,
          FlutterUnionad.NETWORK_STATE_3G,
          FlutterUnionad.NETWORK_STATE_4G,
          FlutterUnionad.NETWORK_STATE_WIFI
        ]); //允许直接下载的网络状态集合 选填

    await FlutterUnionad.requestPermissionIfNecessary();
  }

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _initFlutterUnionad();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // color: Color(0xff61bab3),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SafeArea(
                child: FlutterUnionad.splashAdView(
                  androidCodeId: "887393794", //android 开屏广告广告id 必填
                  iosCodeId: "887393794", //ios 开屏广告广告id 必填
                  supportDeepLink: true, //是否支持 DeepLink 选填
                  expressViewWidth: double.infinity, // 期望view 宽度 dp 必填
                  expressViewHeight: double.infinity,//期望view高度 dp 必填
                  callBack: (FlutterUnionad.FlutterUnionadState state) {
                    print("到这里 ${state.tojson()}");
                    switch (state.type) {
                      case FlutterUnionad.onShow:
                        print(state.tojson());
                        break;
                      case FlutterUnionad.onFail:
                        print(state.tojson());
                        navigationPage();
                        break;
                      case FlutterUnionad.onAplashClick:
                        print(state.tojson());
                        break;
                      case FlutterUnionad.onAplashSkip:
                        print(state.tojson());
                        // Navigator.pop(context);
                        navigationPage();
                        break;
                      case FlutterUnionad.onAplashFinish:
                        print(state.tojson());
                        // Navigator.pop(context);
                        navigationPage();
                        break;
                      case FlutterUnionad.onAplashTimeout:
                        print(state.tojson());
                        // Navigator.pop(context);
                        navigationPage();
                        break;
                    }
                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 64.0,
              child: Center(
                child: FlutterLogo(
                  size: 42.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
