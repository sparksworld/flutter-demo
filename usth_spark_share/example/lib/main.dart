import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:usth_spark_share/usth_spark_share.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await UsthSparkShare.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: [
            FlatButton(
              onPressed: () async {
                await UsthSparkShare.usthWXSceneSession({
                  'shareTitle': "",
                  'shareDesc': '',
                  'shareUrl': '',
                  'shareThumbnail':
                      'http://blog.fe-spark.cn/content/images/2019/07/timg--1----1-1.png'
                });
              },
              child: Text('分享微信好友'),
            ),
            FlatButton(
              onPressed: () async {
                await UsthSparkShare.usthWXSceneTimeline({
                  'shareTitle': Random().nextInt(10000000).toString(),
                  'shareDesc': '我是分享内容',
                  'shareUrl': 'http://blog.fe-spark.cn',
                  'shareThumbnail':
                      'http://blog.fe-spark.cn/content/images/2019/07/timg--1----1-1.png'
                });
              },
              child: Text('分享微信朋友圈'),
            )
          ],
        )),
      ),
    );
  }
}


