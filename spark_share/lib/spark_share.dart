
import 'dart:async';
import 'package:flutter/services.dart';

class SparkShare {
  static List appInfoJson = [];
  static const MethodChannel _channel =
      const MethodChannel('spark_share');


  static initShare(Map options) async {
    if(options['appInfoJson'] == null) return Error();
    appInfoJson = options['appInfoJson'];
    await _channel.invokeMethod('checkAppInstalled');

  }
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
