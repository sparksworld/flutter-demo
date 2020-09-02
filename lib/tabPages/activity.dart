import 'package:flutter/material.dart';
import 'package:flutterdemo/event_bus/index.dart';
import 'package:flutterdemo/states/index.dart';
import 'package:flutterdemo/component/header.dart';
import 'package:flutterdemo/models/index.dart';

class ActivityPage extends StatefulWidget {
  final Function callback;
  ActivityPage({this.callback});

  @override
  State<StatefulWidget> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return CommonHeader(
      title: Text('活动中心'),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Consumer<ThemeModel>(builder: (context, themeModel, child) {
              return Container(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: Colors.purple,
                        onPressed: () {
                          themeModel.setTheme(AppTheme.fromJson(
                              {"primary": Colors.purple.value}));
                        },
                        child: Text(
                          '紫色',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Consumer<ThemeModel>(builder: (context, themeModel, child) {
              return Container(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: Colors.red,
                        onPressed: () {
                          themeModel.setTheme(AppTheme.fromJson(
                              {"primary": Colors.red.value}));
                        },
                        child: Text(
                          '红色',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Consumer<ThemeModel>(builder: (context, themeModel, child) {
              return Container(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          themeModel.setTheme(AppTheme.fromJson(
                              {"primary": Colors.blue.value}));
                        },
                        child: Text(
                          '蓝色',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Consumer<ThemeModel>(builder: (context, themeModel, child) {
              return Container(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: Colors.yellow,
                        onPressed: () {
                          themeModel.setTheme(AppTheme.fromJson(
                              {"primary": Colors.yellow.value}));
                        },
                        child: Text(
                          '黄色',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Consumer<ThemeModel>(builder: (context, themeModel, child) {
              return Container(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          themeModel.setTheme(AppTheme.fromJson(
                              {"primary": Colors.green.value}));
                        },
                        child: Text(
                          '绿色',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Consumer<ThemeModel>(builder: (context, themeModel, child) {
              return Container(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: Colors.pink,
                        onPressed: () {
                          themeModel.setTheme(AppTheme.fromJson(
                              {"primary": Colors.pink.value}));
                        },
                        child: Text(
                          '粉色',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
