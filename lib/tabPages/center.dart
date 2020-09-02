import 'package:flutter/material.dart';
import 'package:flutterdemo/event_bus/index.dart';
import 'package:flutterdemo/event_bus/event_bus.dart';
import 'package:flutterdemo/component/header.dart';

class CenterPage extends StatefulWidget {
  final Function callback;
  CenterPage({this.callback});

  @override
  State<StatefulWidget> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  void onChangeEvent() {
    eventBus.fire(SwitchTab(0));
  }

  @override
  Widget build(BuildContext context) {
    return CommonHeader(
      title: Text('任务中心'),
      body: GestureDetector(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      onPressed: onChangeEvent,
                      child: Text('策四'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
