import 'package:flutter/material.dart';
import 'package:flutterdemo/pages/detail.dart';
import 'dart:math';

class VideoListViewItem extends StatelessWidget {
  final index;
  final length;
  final loading;
  final itemData;
  final Function callback;

  const VideoListViewItem({
    Key key,
    @required this.index,
    @required this.length,
    this.loading,
    this.itemData,
    this.callback,
  }) : super(key: key);

  void _push(BuildContext context, Widget widget) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
  }

  @override
  Widget build(BuildContext context) {
    List _images = itemData.images;
    print('r=' + Random().nextInt(1000).toString());
    return Column(
      children: [
        Container(
          decoration: new BoxDecoration(
            border: new Border(
              bottom: BorderSide(color: Color(0xffE6E6FA), width: 0.5),
              //  color:
            ),
            // 边色与边宽度
            color: Colors.white, // 底色
            //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
            // borderRadius: new BorderRadius.vertical(
            //     top: Radius.elliptical(20, 50)), // 也可控件一边圆角大小
          ),
          child: Card(
            color: Colors.white,
            elevation: 0.0,
            child: GestureDetector(
              onTap: () {
                // callback(1);
                _push(context, DetailPage());
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        itemData.title + '$index',
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
                                  color: Colors.grey,
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
        ),
        index == length - 1
            ? loading
                ? Container(
                    padding: EdgeInsets.fromLTRB(0, 20.0, 0, 36.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('正在加载...')],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.fromLTRB(0, 20.0, 0, 36.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('加载中')],
                    ),
                  )
            : Container()
      ],
    );
  }
}
