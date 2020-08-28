import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterdemo/mainPage/center.dart';

class ListViewItem extends StatelessWidget {
  final index;
  final length;
  final loading;
  final itemData;
  final Function callback;

  const ListViewItem(
      {Key key,
      this.index,
      this.length,
      this.loading,
      this.itemData,
      this.callback})
      : super(key: key);
  void _push(BuildContext context, Widget widget) {
    // log(context)
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
  }

  @override
  Widget build(BuildContext context) {
    List _images = itemData.images;
    return Column(
      children: [
        Card(
          color: Colors.white,
          elevation: 1.0,
          child: GestureDetector(
            onTap: () {
              // callback(1);
              _push(context, CenterPage());
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      itemData.title,
                      style: new TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: _images
                          .map((item) => Container(
                                child: Image.network(item, fit: BoxFit.cover),
                                constraints: BoxConstraints.expand(
                                    width: 110.0, height: 88.0),
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        index == length - 1
            ? loading
                ? Row(
                    children: [Text('正在加载')],
                  )
                : Row(
                    children: [Text('加载中')],
                  )
            : Row()
      ],
    );
  }
}
