import 'package:flutter/cupertino.dart';
import 'package:flutterdemo/common/index.dart';
import 'package:flutterdemo/models/index.dart';
// import 'package:flutterdemo/states/index.dart';
// import 'package:provider/provider.dart';

class NotifierProfileStore extends ChangeNotifier {
  Profile get _profile => Global.profile;

  // NotifierProfileStore() : super();
  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

class TestChange extends NotifierProfileStore {
  double get textScaleFactor => _profile.textScaleFactor ?? 1.0;
  void setTextScaleFactor(double textScale) {
    _profile.textScaleFactor = textScale;
    notifyListeners();
  }
}

class ThemeModel extends NotifierProfileStore {
  Color get theme => Color(_profile.appTheme?.primary ?? 4294198070);

  void setTheme(AppTheme colors) {
    print(_profile.appTheme?.primary);
    _profile.appTheme = colors;
    notifyListeners();
  }
}
