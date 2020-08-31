import 'package:flutter/material.dart';

class CommonHeader extends StatelessWidget {
  final Widget body;
  final Text title;
  CommonHeader({Key key, this.body, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: body,
    );
  }
}
