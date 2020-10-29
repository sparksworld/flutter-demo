# 字节跳动穿山甲广告 Flutter版本

<p>
<a href="https://pub.flutter-io.cn/packages/flutter_unionad"><img src=https://img.shields.io/badge/flutter_unionad-v0.0.6-success></a>
</p>

![image](https://github.com/gstory0404/flutter_unionad/blob/master/image/demo.gif)

## 简介
  flutter_unioad是一款集成了穿山甲Android和iOSSDK的Flutter插件,方便直接调用穿山甲SDK方法开发
## 官方文档
* [Android](https://partner.oceanengine.com/union/media/union/download/detail?id=4&osType=android)
* [IOS](https://partner.oceanengine.com/union/media/union/download/detail?id=16&osType=ios)

## 集成步骤
#### 1、pubspec.yaml
```Dart
flutter_unionad: ^0.0.6
```
引入
```Dart
import 'package:flutter_unionad/flutter_unionad.dart' as FlutterUnionad;
```
#### 2、Android
aar文件已集成进插件中无需额外配置，只需要在android目录中AndroidManifest.xml配置
```Java
  <application
        tools:replace="android:label">
```
SDK版本 3.3.0.0

#### 3、IOS
SDK已配置插件中，其余根据SDK文档配置，因为使用PlatformView，在Info.plist加入
```
 <key>io.flutter.embedded_views_preview</key>
    <true/>
```
SDK版本 3.2.6.2

## 使用

#### 1、SDK初始化
```Dart
await FlutterUnionad.register(
        androidAppId: "5098580", //穿山甲广告 Android appid 必填
        iosAppId:  "5098580", //穿山甲广告 ios appid 必填
        useTextureView: true, //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView 选填
        appName: "unionad_test", //appname 必填
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
```
#### 2、获取SDK版本
```Dart
await FlutterUnionad.getSDKVersion();
```

#### 3、请求权限
```Dart
await FlutterUnionad.requestPermissionIfNecessary();
```
#### 4、开屏广告
```Dart
FlutterUnionad.splashAdView(
        androidCodeId: "887367774", //android 开屏广告广告id 必填
        iosCodeId: "887367774", //ios 开屏广告广告id 必填
        supportDeepLink: true, //是否支持 DeepLink 选填
        expressViewWidth: 750, // 期望view 宽度 dp 必填
        expressViewHeight: 1334, //期望view高度 dp 必填
        callBack: (FlutterUnionad.FlutterUnionadState state) { //广告事件回调 选填
          //广告事件回调 选填
          //type onShow广告成功显示  onFail广告加载失败 onAplashClick开屏广告点击 onAplashSkip开屏广告跳过
          //  onAplashFinish开屏广告倒计时结束 onAplashTimeout开屏广告加载超时
          //params 详细说明
          print("到这里 ${state.tojson()}");
          switch (state.type) {
            case FlutterUnionad.onShow:
              print(state.tojson());
              break;
            case FlutterUnionad.onFail:
              print(state.tojson());
              Navigator.pop(context);
              break;
            case FlutterUnionad.onAplashClick:
              print(state.tojson());
              break;
            case FlutterUnionad.onAplashSkip:
              print(state.tojson());
              Navigator.pop(context);
              break;
            case FlutterUnionad.onAplashFinish:
              print(state.tojson());
              Navigator.pop(context);
              break;
            case FlutterUnionad.onAplashTimeout:
              print(state.tojson());
              Navigator.pop(context);
              break;
          }
        },
      ),
```
#### 5、banner广告
```Dart
FlutterUnionad.bannerAdView(
                androidCodeId: "945410197", //andrrid banner广告id 必填
                iosCodeId: "945410197", //ios banner广告id 必填
                supportDeepLink: true, //是否支持 DeepLink 选填
                expressAdNum: 3, //一次请求广告数量 大于1小于3 选填
                expressTime: 30, //轮播间隔事件 秒  选填
                expressViewWidth: 600.5, // 期望view 宽度 dp 必填
                expressViewHeight: 120.5, //期望view高度 dp 必填
                callBack: (FlutterUnionad.FlutterUnionadState state) { //广告事件回调 选填
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
                }),
```

#### 6、信息流广告
```
FlutterUnionad.nativeAdView(
              androidCodeId: "945410197", //android banner广告id 必填
              iosCodeId: "945410197", //ios banner广告id 必填
              supportDeepLink: true, //是否支持 DeepLink 选填
              expressViewWidth: 600.5, // 期望view 宽度 dp 必填
              expressViewHeight: 120.5, //期望view高度 dp 必填
              callBack: (FlutterUnionad.FlutterUnionadState state) { //广告事件回调 选填
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
            ),
```

#### 7、插屏广告
```Dart
await FlutterUnionad.interactionAd(
                  androidCodeId: "945417892",//andrrid 插屏广告id 必填
                  iosCodeId: "945417892",//ios 插屏广告id 必填
                  supportDeepLink: true, //是否支持 DeepLink 选填
                  expressViewWidth: 300.0, // 期望view 宽度 dp 必填
                  expressViewHeight: 450.0, //期望view高度 dp 必填
                );
```
#### 8、激励视频
```Dart
FlutterUnionad.loadRewardVideoAd(
                    mIsExpress: true, //是否个性化 选填
                    androidCodeId: "945418088", //Android 激励视频广告id  必填
                    iosCodeId: "945418088", //ios 激励视频广告id  必填
                    supportDeepLink: true, //是否支持 DeepLink 选填
                    rewardName: "100金币", //奖励名称 选填
                    rewardAmount: 100, //奖励数量 选填
                    userID: "123",  //  用户id 选填
                    orientation: FlutterUnionad.VideoVERTICAL, //视屏方向 选填
                    mediaExtra: null, //扩展参数 选填
                );
```
监听激励视频状态

```Dart
 StreamSubscription _adViewStream = FlutterUnionad.adeventEvent
       .receiveBroadcastStream()
       .listen((data) {
     if (data[FlutterUnionad.adType] == FlutterUnionad.rewardAd) {
       print("激励广告结果----->  rewardVerify=${data[FlutterUnionad.rewardVerify]} "
           "rewardName=${data[FlutterUnionad.rewardName]} "
           "rewardAmount=${data[FlutterUnionad.rewardAmount]} ");
     }
   });
```
#### 9、draw视频广告
```Dart
FlutterUnionad.drawFeedAdView(
                androidCodeId: "945426252", // Android draw视屏广告id 必填
                iosCodeId: "945426252", //ios draw视屏广告id 必填
                supportDeepLink: true, //是否支持 DeepLink 选填
                expressViewWidth: 600.5, // 期望view 宽度 dp 必填
                expressViewHeight: 800.5, //期望view高度 dp 必填
                callBack: (FlutterUnionad.FlutterUnionadState state) { //广告事件回调 选填
                  //type onShow显示广告 onFail广告加载失败
                  //params 详细说明
                  switch (state.type) {
                    case FlutterUnionad.onShow:
                      print(state.tojson());
                      break;
                    case FlutterUnionad.onFail:
                      print(state.tojson());
                      break;
                  }
                },
              ),
```

### 10、全屏视频广告
```Dart
 FlutterUnionad.fullScreenVideoAd(
                  androidCodeId: "945491318", //android 全屏广告id 必填
                  iosCodeId: "945491318",//ios 全屏广告id 必填
                  supportDeepLink: true,  //是否支持 DeepLink 选填
                  orientation: FlutterUnionad.VideoVERTICAL,//视屏方向 选填
              );
```
结果监听
```Dart
FlutterUnionad.adeventEvent
       .receiveBroadcastStream()
       .listen((data) {
     if(data[FlutterUnionad.adType] == FlutterUnionad.fullVideoAd){
        switch(data[FlutterUnionad.fullVideoType]){
          case FlutterUnionad.onAdShow:
            print("全屏广告显示");
            break;
          case FlutterUnionad.onAdVideoBarClick:
            print("全屏广告返回");
            break;
          case FlutterUnionad.onAdClose:
            print("全屏广告关闭");
            break;
          case FlutterUnionad.onVideoComplete:
            print("全屏广告继续");
            break;
          case FlutterUnionad.onSkippedVideo:
            print("全屏广告跳过");
            break;
        }
     }
   });
```

## 联系方式
* Email: gstory0404@gmail.com
* QQ: 156496037
 
