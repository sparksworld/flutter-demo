import 'package:flutter/material.dart';
import 'package:flutterdemo/event_bus/event_bus.dart';
import 'package:flutterdemo/states/index.dart';
import 'package:flutterdemo/component/header.dart';

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
      body: GestureDetector(
        onTap: () {
          widget.callback(0);
        },
        child: Center(
          child: FloatingActionButton(
            heroTag: Text('data'),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              // widget.callback(0);
              eventBus.fire(SwitchTab(1));
            },
            child: Icon(Icons.date_range),
          ),
        ),
      ),
    );
  }
}
