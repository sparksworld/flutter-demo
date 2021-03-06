import 'dart:async';

import 'package:flutter/services.dart';

class SparkShare {
  static const MethodChannel _channel = const MethodChannel('spark_share');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static initShare(data) async {
    return await _channel.invokeMethod('initShare', data);
  }

  static getAppInfoList() async {
    return await _channel.invokeMethod('getAppInfoList');
  }

  static checkAppInstalled() async {
    return await _channel.invokeMethod('checkAppInstalled');
  }

  static usthWXSceneSession(data) async {
    return await _channel.invokeMethod('usthWXSceneSession', data);
  }

  static usthWXSceneTimeline(data) async {
    return await _channel.invokeMethod('usthWXSceneTimeline', data);
  }

  static usthWXSceneSessionWithText(String text) async {
    return await _channel.invokeMethod('usthWXSceneSessionWithText', text);
  }

  static usthWXSceneTimelineWithText(String text) async {
    return await _channel.invokeMethod('usthWXSceneTimelineWithText', text);
  }

  // static usthWX
}
