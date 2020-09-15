import 'package:flutterdemo/widgets/spark_chewie.dart';
import 'package:flutterdemo/module.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
// import 'custom_controls.dart';

class VideoPlay extends StatefulWidget {
  final arguments;
  VideoPlay({this.arguments});

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayState();
  }
}

class _VideoPlayState extends State<VideoPlay> {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  bool isInit;
  double aspectRatio;
  double initHeight;
  double initWidth;
  void _listener() async {
    bool isKeptOn = await Wakelock.isEnabled;
    if (videoPlayerController.value.isPlaying && !isKeptOn) {
      Wakelock.enable();
    }
  }

  @override
  void initState() {
    initWidth = double.infinity;
    initHeight = 210.px;
    new Future.delayed(Duration.zero, () {
      ListItem argv = ModalRoute.of(context).settings.arguments;
      videoPlayerController = VideoPlayerController.network(
        argv.videoUrl,
      )
        ..addListener(_listener)
        ..initialize().then((_) => setState(() {
              aspectRatio = videoPlayerController.value.aspectRatio;
              chewieController = ChewieController(
                videoPlayerController: videoPlayerController,
                aspectRatio: aspectRatio,
                autoPlay: true,
                looping: false,
                // customControls: CustomControls()
              );
            }));
    });
    // chewieController =
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values); //恢复
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Wakelock.disable();
    videoPlayerController.removeListener(_listener);
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Stack(
              children: [
                Container(
                  width: initWidth,
                  height: initHeight,
                  child: aspectRatio != null
                      ? Chewie(
                          controller: chewieController,
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                Positioned(
                  left: 12.0,
                  top: 12.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                //AppBar，包含一个导航栏
                // SliverAppBar(
                //   pinned: true,
                //   expandedHeight: 250.0,
                //   flexibleSpace: FlexibleSpaceBar(
                //     title: const Text('Demo'),
                //   ),
                // ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: new SliverGrid(
                    //Grid
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //Grid按两列显示
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 4.0,
                    ),
                    delegate: new SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        //创建子widget
                        return new Container(
                          alignment: Alignment.center,
                          color: Colors.cyan[100 * (index % 9)],
                          child: new Text('grid item $index'),
                        );
                      },
                      childCount: 20,
                    ),
                  ),
                ),
                //List
                new SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: new SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    //创建列表项
                    return new Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue[100 * (index % 9)],
                      child: new Text('list item $index'),
                    );
                  }, childCount: 50 //50个列表项
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
