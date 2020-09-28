import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spark_share/spark_share.dart';

void main() {
  const MethodChannel channel = MethodChannel('spark_share');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SparkShare.getAppInfoList(), '42');
  });
}
