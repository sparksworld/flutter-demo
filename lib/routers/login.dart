import 'package:flutterdemo/module.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class LoginRoute extends StatefulWidget {
  final arguments;
  LoginRoute({Key key, this.arguments}) : super(key: key);
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //密码是否显示明文
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = '';
    _pwdController.text = '';

    fluwx.weChatResponseEventHandler.listen((res) {
      if (res is fluwx.WeChatAuthResponse) {
        setState(() {
          _unameController.text = 'Code:' + res.code.toString();
          _pwdController.text = 'lang:' + res.lang.toString();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('测试登陆')),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      autofocus: _nameAutoFocus,
                      controller: _unameController,
                      decoration: InputDecoration(
                        labelText: '用户名',
                        hintText: 'username',
                        prefixIcon: Icon(Icons.person),
                      ),
                      // 校验用户名（不能为空）
                      validator: (v) {
                        return v.trim().isNotEmpty ? null : "用户名不能为空";
                      }),
                  TextFormField(
                    controller: _pwdController,
                    autofocus: !_nameAutoFocus,
                    decoration: InputDecoration(
                        labelText: '密码',
                        hintText: 'password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(pwdShow
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              pwdShow = !pwdShow;
                            });
                          },
                        )),
                    obscureText: !pwdShow,
                    //校验密码（不能为空）
                    validator: (v) {
                      return v.trim().isNotEmpty ? null : "密码不能为空";
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.expand(height: 55.0),
                      child: ChangeNotifierProvider(
                        create: (context) => UserModel(),
                        child: Consumer<UserModel>(
                          builder: (BuildContext context, UserModel userModel,
                              Widget child) {
                            return RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () async =>
                                  _onLogin(context, userModel),
                              textColor: Colors.white,
                              child: Text("立即登陆"),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.expand(height: 55.0),
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () => {
                          print(11111111),
                          fluwx.sendWeChatAuth(
                            scope: "snsapi_userinfo",
                            state: "wechat_sdk_demo_test",
                          ),
                        },
                        textColor: Colors.white,
                        child: Text("微信一键登陆"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onLogin(context, userModel) async {
    if ((_formKey.currentState as FormState).validate()) {
      ApiList.getUserInfo({
        "username": _unameController.text,
        "password": _pwdController.text
      }).then(
        (value) => {
          userModel.setUserInfo(value),
          if (userModel.userInfo.token != null) {Navigator.pop(context, true)},
        },
      );
    }
  }
}
