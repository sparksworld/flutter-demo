import 'package:flutter/material.dart';
// import 'package:event_bus/event_bus.dart';
import 'package:flutterdemo/event_bus/event_bus.dart';
import 'package:flutterdemo/events/index.dart';
import "package:flutterdemo/event_bus/event_bus.dart";

class Activity extends StatefulWidget {
  final Function callback;
  Activity({this.callback});

  @override
  State<StatefulWidget> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callback(0);
      },
      child: Center(
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            // widget.callback(0);
            eventBus.fire(SwitchTab(1));
          },
          child: Icon(Icons.date_range),
        ),
      ),
    );
  }
}
