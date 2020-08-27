import 'package:flutter/material.dart';

class CenterPage extends StatefulWidget {
  final Function callback;
  CenterPage({this.callback});

  @override
  State<StatefulWidget> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callback(2);
      },
      child: Column(
        children: [Text('22222'), Text('22222'), Text('22222'), Text('22222')],
      ),
    );
  }
}
