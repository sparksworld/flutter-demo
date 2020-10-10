import 'dart:async';

import 'package:flutter/services.dart';

class UsthSparkShare {
  static const MethodChannel _channel = const MethodChannel('usth_spark_share');

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

  static usthWxFriendShare(data) async {
    return await _channel.invokeMethod('usthWxFriendShare', data);
  }

  static usthWxCircleOfFriendsShare(data) async {
    return await _channel.invokeMethod('usthWxCircleOfFriendsShare', data);
  }
}
