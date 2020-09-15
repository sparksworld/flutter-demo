import 'package:flutterdemo/module.dart';

class VideoListViewItem extends StatelessWidget {
  final itemData;
  final Function callback;

  const VideoListViewItem({
    Key key,
    this.itemData,
    this.callback,
  }) : super(key: key);

  // void _push(BuildContext context, Widget widget) {
  //   Navigator.push(context,
  //       new MaterialPageRoute(builder: (BuildContext context) {
  //     return widget;
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    // print(itemData());
    List _images = itemData.strImages.toList();
    // print('r=' + Random().nextInt(1000).toString());
    return Container(
      margin: EdgeInsets.fromLTRB(0.0.px, 6.0.px, 0.0.px, 6.0.px),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: BorderSide(color: Color(0xffE6E6FA), width: 0.5.px),
        ),
        color: Colors.white, // 底色
      ),
      child: Column(
        children: [
          Container(
            decoration: new BoxDecoration(
              // border: new Border(
              //   bottom: BorderSide(color: Color(0xffE6E6FA), width: 0.5),
              // ),
              // boxShadow: ,
              image: DecorationImage(
                image: NetworkImage(_images[0]['image']),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.multiply),
              ),
              // 边色与边宽度
              color: Colors.grey, // 底色
              // borderRadius: new BorderRadius.circular((10.0.px)), // 圆角度
              // borderRadius: new BorderRadius.vertical(
              //     top: Radius.elliptical(20, 50)), // 也可控件一边圆角大小
            ),
            child: GestureDetector(
                onTap: () {
                  // callback(1);
                  // Navigator.pushNamed(context, '/articleDetail',
                  //   arguments: itemData);
                  Navigator.pushNamed(context, '/videoPlay', arguments: itemData);
                  // _push(context, DetailPage());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(12.0.px, 10.0.px, 12.0.px, 0),
                      child: Text(
                        itemData.tTitle,
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 152.0.px,
                      padding: EdgeInsets.only(bottom: 10.0.px),
                      child: Center(
                          child: Container(
                        decoration: new BoxDecoration(
                          color: Colors.black.withOpacity(.5),
                          borderRadius: BorderRadius.circular(100.0.px),
                        ),
                        width: 60.0.px,
                        height: 60.0.px,
                        child: Icon(
                          Icons.play_arrow,
                          size: 50.0.px,
                          color: Colors.white70,
                        ),
                      )),
                    )
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0.px, 10.0.px, 10.0.px, 10.0.px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemData.tuName ?? '',
                  style: TextStyle(color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 6.0.px),
                      child: Icon(
                        Icons.comment,
                        color: Colors.grey,
                        size: 18.0.px,
                      ),
                    ),
                    Text(
                      itemData.commentCount.toString() ?? '',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
