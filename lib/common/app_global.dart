import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterdemo/models/profile.dart';
import 'package:flutterdemo/request/index.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();

  static bool get isRelease => bool.fromEnvironment("dart.vm.product");
  static get isWeChatInstalled async => await fluwx.isWeChatInstalled;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var a = await fluwx.registerWxApi(
      appId: "wx3010dec59a92e1a7",
      doOnIOS: true,
      doOnAndroid: true,
      universalLink: "https://www.baidu.com/",
    );
    print(a);

    // _prefs.clear();//清空键值对
    var _profile = _prefs.getString("profile");

    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }
    ApiList();
  }

  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}
