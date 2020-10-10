import 'dart:async';

import 'package:flutter/services.dart';

class UsthSparkShare {
  static const MethodChannel _channel = const MethodChannel('usth_spark_share');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future usthWxFriendShare(data) async {
    return await _channel.invokeMethod('usthWxFriendShare', data);
  }

  static Future usthWxCircleOfFriendsShare(data) async {
    return await _channel.invokeMethod('usthWxCircleOfFriendsShare', data);
  }
}
