import 'package:flutter/material.dart';

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
            widget.callback(0);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
