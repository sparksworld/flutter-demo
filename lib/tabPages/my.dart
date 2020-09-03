import 'package:flutterdemo/module.dart';

class MyPage extends StatefulWidget {
  final Function callback;
  MyPage({this.callback});

  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  void onChangeEvent() {
    eventBus.fire(SwitchTab(0));
  }

  @override
  Widget build(BuildContext context) {
    return CommonHeader(
      title: Text('我的'),
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
          // Card(
          //   child: ListTile(
          //     leading: FlutterLogo(),
          //     title: Text('One-line with leading widget'),
          //   ),
          // ),
          // Card(
          //   child: ListTile(
          //     title: Text('One-line with trailing widget'),
          //     trailing: Icon(Icons.more_vert),
          //   ),
          // ),
          // Card(
          //   child: ListTile(
          //     leading: FlutterLogo(),
          //     title: Text('One-line with both widgets'),
          //     trailing: Icon(Icons.more_vert),
          //   ),
          // ),
          // Card(
          //   child: ListTile(
          //     title: Text('One-line dense ListTile'),
          //     dense: true,
          //     trailing: Icon(Icons.navigate_next),
          //   ),
          // ),
          // Card(
          //   child: ListTile(
          //     leading: FlutterLogo(size: 56.0),
          //     title: Text('Two-line ListTile'),
          //     subtitle: Text('Here is a second line'),
          //     trailing: Icon(Icons.more_vert),
          //   ),
          // ),
          // Card(
          //   child: ListTile(
          //     leading: FlutterLogo(size: 72.0),
          //     title: Text('Three-line ListTile'),
          //     subtitle:
          //         Text('A sufficiently long subtitle warrants three lines.'),
          //     trailing: Icon(Icons.arrow_forward),
          //     isThreeLine: true,
          //   ),
          // ),
        ],
      ),
    );
  }
}
