// import 'package:flutter/material.dart';
import 'package:flutterdemo/module.dart';

// import 'package:flutterdemo/pages/detail.dart';
// import 'dart:math';

class HomeListViewItem extends StatelessWidget {
  // final index;
  // final length;
  // final loading;
  final itemData;
  final Function callback;

  const HomeListViewItem({
    Key key,
    // @required this.index,
    // @required this.length,
    // this.loading,
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
    // print(itemData());
    List _images = itemData.strImages.toList();
    // print('r=' + Random().nextInt(1000).toString());
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
                Navigator.pushNamed(context, '/articleDetail');
                // _push(context, DetailPage());
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        itemData.tTitle,
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: new TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.5
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _images
                            .map((item) => SizedBox(
                                  width: 110.px,
                                  height: 88.px,
                                  child: CachedNetworkImage(
                                    imageUrl: item['image'],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                      width: 110.px,
                                      height: 88.px,
                                      color: Color(0xffd5d5d5),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
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
      ],
    );
  }
}
