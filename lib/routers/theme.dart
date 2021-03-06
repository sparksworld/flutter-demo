import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterdemo/widgets/header.dart';
import 'package:flutterdemo/states/index.dart';
import 'package:flutterdemo/models/index.dart';

List themes = <Map>[
  {'title': '默认', 'color': const Color(0xFF7fb9b3)},
  {'title': '烈焰红', 'color': Colors.red},
  {'title': '青草绿', 'color': Colors.green},
  {'title': '尊贵紫', 'color': Colors.purple},
  {'title': '少女粉', 'color': Colors.pink},
  {'title': '骚气黄', 'color': Colors.yellow},
  {'title': '天空蓝', 'color': Colors.blue},
  {'title': '美年橙', 'color': Colors.orange},
  {'title': '炫酷黑', 'color': Colors.black},
];

class ThemeSetting extends StatelessWidget {
  final arguments;
  ThemeSetting({Key key, this.arguments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(Provider.of<ThemeModel>(context).theme);
    return CommonHeader(
      title: Text('主题设置'),
      body: Container(
        // padding: EdgeInsets.only(top: 4.0),
        child: new StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: themes.length,
          itemBuilder: (BuildContext context, int index) =>
              Consumer<ThemeModel>(
            builder: (BuildContext context, themeModel, Widget child) {
              return GestureDetector(
                onTap: () {
                  print(const Color(0xFF7fb9b3).value);
                  print(111111);
                  themeModel.setTheme(
                    AppTheme.fromJson(
                      {'primary': themes[index]['color'].value},
                    ),
                  );
                },
                child: new Container(
                  color: themes[index]['color'],
                  child: new Center(
                    child: new Text(
                      themes[index]['title'],
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                  ),
                ),
              );
            },
          ),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index % 2 == 0 ? 2 : 3),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}
