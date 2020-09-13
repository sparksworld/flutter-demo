import 'package:flutterdemo/module.dart';
import 'package:flutterdemo/widgets/header.dart';

class Setting extends StatelessWidget {
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
            child: Consumer<TestChange>(builder:
                (BuildContext context, TestChange testChange, Widget child) {
              return InkWell(
                // onTap: () => DmPuppeteer.init(),
                child: ListTile(
                  leading: FlutterLogo(),
                  title: Text('斗米自动化'),
                  trailing: Icon(Icons.navigate_next),
                ),
              );
            }),
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
