import 'package:flutter/cupertino.dart';
import 'package:flutterdemo/common/appGlobal.dart';
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
  int count = 1;

  void add() {
    print(_profile.appTheme ?? 1);
    count += 1;
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
