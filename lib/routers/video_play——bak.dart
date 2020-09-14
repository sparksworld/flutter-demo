import 'package:flutterdemo/module.dart';
// import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutterdemo/widgets/video_widget.dart';
import 'dart:developer';

class VideoPlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideoPlayState();
  }
}

class _VideoPlayState extends State<VideoPlay> with WidgetsBindingObserver {

  ListItem args;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // controller.setIjkPlayerOptions(
    //   [
    //     Platform.isAndroid ? TargetPlatform.android: TargetPlatform.iOS,
    //   ],
    //   [
    //     IjkOption(IjkOptionCategory.player,
    //         Platform.isAndroid ? "mediacodec" : "videotoolbox", 0),
    //   ],
    // );

  }

  @override
  void dispose() {
    // controller.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
  
    return Scaffold(
      // appBar: PreferredSizeWidget(),
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          // child: VideoWidget(),
        ),
      ),
    );
  }

}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SliverCustomHeaderDelegate(this.child);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 245.0;

  @override
  // TODO: implement minExtent
  double get minExtent => 245.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}
