import 'dart:math';

import 'package:flutterdemo/widgets/chewie.dart';
import 'package:flutterdemo/module.dart';
import 'dart:developer';
import 'package:video_player/video_player.dart';
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

  @override
  void initState() {
    // var context = ;
    new Future.delayed(Duration.zero, () {
      ListItem argv = ModalRoute.of(context).settings.arguments;
      videoPlayerController = VideoPlayerController.network(
        argv.videoUrl,
      )..initialize().then((_) => setState(() {
            aspectRatio = videoPlayerController.value.aspectRatio;
            chewieController = ChewieController(
              videoPlayerController: videoPlayerController,
              aspectRatio: aspectRatio,
              autoPlay: true,
              looping: true,
              // customControls: CustomControls()
            );
          }));
    });
    // chewieController =
    super.initState();
  }

  @override
  void dispose() {
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
              height: 210.0.px,
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
