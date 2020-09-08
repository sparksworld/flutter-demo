import 'package:flutter/material.dart';
import 'package:flutterdemo/widgets/header.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return CommonHeader(
      title: Text('详情'),
      body: Text('data'),
    );
  }
}
