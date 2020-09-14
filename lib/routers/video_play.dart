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
  void _listener() async {
    bool isKeptOn = await Wakelock.isEnabled;
    if (videoPlayerController.value.isPlaying && !isKeptOn) {
      Wakelock.enable();
    }
  }

  @override
  void initState() {
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
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
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
              left: 12.0.px,
              top: 12.0.px,
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
    );
  }
}
