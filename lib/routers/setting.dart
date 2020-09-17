import 'package:flutterdemo/module.dart';
import 'package:flutterdemo/widgets/header.dart';

class Setting extends StatefulWidget {
  final arguments;
  Setting({Key key, this.arguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingState();
  }
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return CommonHeader(
      title: Text('设置'),
      body: ListView(
        children: <Widget>[
          Card(
            child: InkWell(
              onTap: () {
                print(MediaQuery.of(context).toString());
                Navigator.pushNamed(context, "/themeSetting");
              },
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('主题设置'),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
          ),
          Card(
            child: Consumer<TestChange>(builder:
                (BuildContext context, TestChange testChange, Widget child) {
              return InkWell(
                onTap: () {
                  // testChange.setTextScaleFactor(1.0);
                  // print(MediaQuery.of(context).toString());
                  Navigator.pushNamed(context, "/settingText");
                },
                child: ListTile(
                  leading: FlutterLogo(),
                  title: Text('字体设置'),
                  trailing: Icon(Icons.navigate_next),
                ),
              );
            }),
          ),
          Card(
            child: LoginButton(),
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginButton();
  }
}

class _LoginButton extends State<LoginButton> {
  User _userInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel userModel, Widget child) {
        _userInfo = userModel.userInfo;
        return InkWell(
          onTap: () => {
            if ((userModel.userInfo?.token) != null)
              {
                userModel.setUserInfo(User.fromJson({})),
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("退出成功"),
                  ),
                )
              }
            else
              {
                Navigator.pushNamed(context, '/login').then(
                  (value) => {
                    if (value == true)
                      {
                        setState(() {
                          _userInfo = userModel.userInfo;
                        })
                      }
                  },
                ),
              }
          },
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: ((_userInfo?.token) != null) ? Text('退出登陆') : Text('登陆'),
            trailing: Icon(Icons.navigate_next),
          ),
        );
      },
    );
  }
}
