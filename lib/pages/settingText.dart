import 'package:flutterdemo/module.dart';
import 'package:flutterdemo/widgets/header.dart';

class SettingTextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingTextPage();
  }
}

class _SettingTextPage extends State<SettingTextPage> {
  Map active = {
    "small": 0.9,
    "middle": 1.0,
    "big": 1.2,
  };
  @override
  Widget build(BuildContext context) {
    return CommonHeader(
      title: Text('字体设置'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "演示字体",
                      style: TextStyle(fontSize: 17.0.px, height: 2),
                    ),
                    Text(
                      'Demonstrate the font',
                      style: TextStyle(fontSize: 17.0.px, height: 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Consumer<TestChange>(builder: (context, testChange, child) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Color(0xffE6E6FA), width: 0.5))),
                  child: CheckboxListTile(
                      title: Text('小号字体'),
                      // subtitle: Text('this is subtitle'),
                      value: active["small"] == testChange.textScaleFactor,
                      onChanged: (value) {
                        if (value) {
                          testChange.setTextScaleFactor(active["small"]);
                        }
                      }),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Color(0xffE6E6FA), width: 0.5))),
                  child: CheckboxListTile(
                      title: Text('中号字体'),
                      // subtitle: Text('this is subtitle'),
                      value: active["middle"] == testChange.textScaleFactor,
                      onChanged: (value) {
                        if (value) {
                          testChange.setTextScaleFactor(active["middle"]);
                        }
                      }),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Color(0xffE6E6FA), width: 0.5))),
                  child: CheckboxListTile(
                      title: Text('大号字体'),
                      // subtitle: Text('this is subtitle'),
                      value: active["big"] == testChange.textScaleFactor,
                      onChanged: (value) {
                        if (value) {
                          testChange.setTextScaleFactor(active["big"]);
                        }
                      }),
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}
