// import 'package:flutter/material.dart';
import 'package:flutterdemo/module.dart';

// import 'package:flutterdemo/pages/detail.dart';
// import 'dart:math';
class ArticleListViewItem extends StatefulWidget {
  final ListItem itemData;
  final Function callback;

  const ArticleListViewItem({
    Key key,
    // @required this.index,
    // @required this.length,
    // this.loading,
    this.itemData,
    this.callback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ArticleListViewItemState();
  }
}

class _ArticleListViewItemState extends State<ArticleListViewItem> {
  // final index;
  // final length;
  // final loading;

  // void _push(BuildContext context, Widget widget) {
  //   Navigator.push(context,
  //       new MaterialPageRoute(builder: (BuildContext context) {
  //     return widget;
  //   }));
  // }
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List _images = widget.itemData.strImages.toList();
    
    return Column(
      children: [
        Container(
          child: Card(
            color: Colors.white,
            elevation: 0.0,
            child: GestureDetector(
              onTap: () {
                // callback(1);
                Navigator.pushNamed(context, '/articleDetail',
                    arguments: widget.itemData);
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
                        widget.itemData.tTitle,
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: new TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.5),
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
