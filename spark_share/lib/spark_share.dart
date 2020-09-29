import 'dart:async';
import 'package:flutter/services.dart';

class SparkShare {
  static const MethodChannel _channel = const MethodChannel('spark_share');

  static initShare(data) async {
    return await _channel.invokeMethod('initShare', data);
  }

  static getAppInfoList() async {
    return await _channel.invokeMethod('getAppInfoList');
  }

  static checkAppInstalled() async {
    return await _channel.invokeMethod('checkAppInstalled');
  }

  static shareWeChat(data) async {
    return await _channel.invokeMethod('shareWeChat', data);
  }
}
