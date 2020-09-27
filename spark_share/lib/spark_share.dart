
import 'dart:async';

import 'package:flutter/services.dart';

class SparkShare {
  static const MethodChannel _channel =
      const MethodChannel('spark_share');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
