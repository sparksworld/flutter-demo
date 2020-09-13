// import 'package:video_player/video_player.dart';
// import 'package:flutterdemo/module.dart';
// // import 'package:flutterdemo/widgets/header.dart';

// class MyVideo extends StatefulWidget {
//   MyVideo({
//     @required this.url, // 当前需要播放的地址
//     @required this.width, // 播放器尺寸（大于等于视频播放区域）
//     @required this.height,
//     this.title = '', // 视频需要显示的标题
//   });

//   // 视频地址
//   final String url;
//   // 视频尺寸比例
//   final double width;
//   final double height;
//   // 视频标题
//   final String title;

//   @override
//   State<MyVideo> createState() {
//     return _MyVideoState();
//   }
// }

// class _MyVideoState extends State<MyVideo> {
//   // 指示video资源是否加载完成，加载完成后会获得总时长和视频长宽比等信息
//   bool _videoInit = false;
//   // video控件管理器
//   VideoPlayerController _controller;
//   // 记录video播放进度
//   Duration _position = Duration(seconds: 0);
//   // 记录播放控件ui是否显示(进度条，播放按钮，全屏按钮等等)
//   Timer _timer; // 计时器，用于延迟隐藏控件ui
//   bool _hidePlayControl = true; // 控制是否隐藏控件ui
//   double _playControlOpacity = 0; // 通过透明度动画显示/隐藏控件ui
//   // 记录是否全屏
//   bool get _isFullScreen =>
//       MediaQuery.of(context).orientation == Orientation.landscape;

//   @override
//   Widget build(BuildContext context) {
//     // 控件ui下半部
//     Widget _bottomControl = Positioned(
//       // 需要定位
//       left: 0,
//       bottom: 0,
//       child: Offstage(
//         // 控制是否隐藏
//         offstage: _hidePlayControl,
//         child: AnimatedOpacity(
//           // 加入透明度动画
//           opacity: _playControlOpacity,
//           duration: Duration(milliseconds: 300),
//           child: Container(
//             // 底部控件的容器
//             width: widget.width,
//             height: 40,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 // 来点黑色到透明的渐变优雅一下
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 colors: [
//                   Color.fromRGBO(0, 0, 0, .7),
//                   Color.fromRGBO(0, 0, 0, .1)
//                 ],
//               ),
//             ),
//             child: _videoInit
//                 ? Row(
//                     // 加载完成时才渲染,flex布局
//                     children: <Widget>[
//                       IconButton(
//                         // 播放按钮
//                         padding: EdgeInsets.zero,
//                         iconSize: 26,
//                         icon: Icon(
//                           // 根据控制器动态变化播放图标还是暂停
//                           _controller.value.isPlaying
//                               ? Icons.pause
//                               : Icons.play_arrow,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             // 同样的，点击动态播放或者暂停
//                             _controller.value.isPlaying
//                                 ? _controller.pause()
//                                 : _controller.play();
//                             _startPlayControlTimer(); // 操作控件后，重置延迟隐藏控件的timer
//                           });
//                         },
//                       ),
//                       Flexible(
//                         // 相当于前端的flex: 1
//                         child: VideoProgressIndicator(
//                           // 嘻嘻，这是video_player编写好的进度条，直接用就是了~~
//                           _controller,
//                           allowScrubbing: true, // 允许手势操作进度条
//                           padding: EdgeInsets.all(0),
//                           colors: VideoProgressColors(
//                             // 配置进度条颜色，也是video_player现成的，直接用
//                             playedColor:
//                                 Theme.of(context).primaryColor, // 已播放的颜色
//                             bufferedColor:
//                                 Color.fromRGBO(255, 255, 255, .5), // 缓存中的颜色
//                             backgroundColor:
//                                 Color.fromRGBO(255, 255, 255, .2), // 为缓存的颜色
//                           ),
//                         ),
//                       ),
//                       Container(
//                         // 播放时间
//                         margin: EdgeInsets.only(left: 10),
//                         child: Text(
//                           '111111',
//                           // durationToTime是通过Duration转成hh:mm:ss的格式，自己实现。
//                           // durationToTime(_position) +
//                           //     '/' +
//                           //     durationToTime(_controller.value.duration),
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       IconButton(
//                         // 全屏/横屏按钮
//                         padding: EdgeInsets.zero,
//                         iconSize: 26,
//                         icon: Icon(
//                           // 根据当前屏幕方向切换图标
//                           _isFullScreen
//                               ? Icons.fullscreen_exit
//                               : Icons.fullscreen,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {
//                           // 点击切换是否全屏
//                           _toggleFullScreen();
//                         },
//                       ),
//                     ],
//                   )
//                 : Container(),
//           ),
//         ),
//       ),
//     );

//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//         width: double.infinity,
//         height: 255.px,
//         color: Colors.black,
//         child: widget.url != null
//             ? Stack(
//                 overflow: Overflow.clip,
//                 // 因为控件ui和视频是重叠的，所以要用定位了
//                 children: <Widget>[
//                   GestureDetector(
//                     // 手势组件
//                     onTap: () {
//                       // 点击显示/隐藏控件ui
//                       _togglePlayControl();
//                     },
//                     child: _videoInit
//                         ? Center(
//                             child: AspectRatio(
//                               // 加载url成功时，根据视频比例渲染播放器
//                               aspectRatio: _controller.value.aspectRatio,
//                               child: VideoPlayer(_controller),
//                             ),
//                           )
//                         : Center(
//                             // 没加载完成时显示转圈圈loading
//                             child: SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(),
//                             ),
//                           ),
//                   ),
//                   _bottomControl // 控件ui下半部 看下面
//                 ],
//               )
//             : Center(
//                 // 判断是否传入了url，没有的话显示"暂无视频信息"
//                 child: Text(
//                   '暂无视频信息',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     _urlChange(); // 初始进行一次url加载
//     super.initState();
//   }

//   @override
//   void didUpdateWidget(MyVideo oldWidget) {
//     if (oldWidget.url != widget.url) {
//       _urlChange(); // url变化时重新执行一次url加载
//     }
//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   void dispose() {
//     if (_controller != null) {
//       // 惯例。组件销毁时清理下
//       _controller.removeListener(_videoListener);
//       _controller.dispose();
//     }
//     super.dispose();
//   }

//   void _urlChange() {
//     if (mounted) {
//       if (widget.url == null || widget.url == '') return;
//       if (_controller != null) {
//         // 如果控制器存在，清理掉重新创建
//         _controller.removeListener(_videoListener);
//         _controller.dispose();
//       }
//       setState(() {
//         // 重置组件参数
//         _hidePlayControl = false;
//         _position = Duration(seconds: 0);
//       });
//       // 加载network的url，也支持本地文件，自行阅览官方api
//       _controller = VideoPlayerController.network(widget.url)
//         ..initialize().then((_) {
//           // 加载资源完成时，监听播放进度，并且标记_videoInit=true加载完成
//           _controller?.addListener(_videoListener);
//           setState(() {
//             _videoInit = true;
//           });
//         });
//     }
//   }

//   void _videoListener() async {
//     Duration res = await _controller?.position;
//     if (mounted) {
//       if (res >= _controller.value.duration) {
//         _controller.pause();
//         _controller.seekTo(Duration(seconds: 0));
//       }
//       setState(() {
//         _position = res;
//       });
//     }
//   }

//   void _togglePlayControl() {
//     if (mounted) {
//       setState(() {
//         if (_hidePlayControl) {
//           // 如果隐藏则显示
//           _hidePlayControl = false;
//           _playControlOpacity = 1;
//           _startPlayControlTimer(); // 开始计时器，计时后隐藏
//         } else {
//           // 如果显示就隐藏
//           if (_timer != null) _timer.cancel(); // 有计时器先移除计时器
//           _playControlOpacity = 0;
//           Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
//             _hidePlayControl = true; // 延迟300ms(透明度动画结束)后，隐藏
//           });
//         }
//       });
//     }
//   }

//   void _startPlayControlTimer() {
//     // 计时器，用法和前端js的大同小异
//     if (_timer != null) _timer.cancel();
//     _timer = Timer(Duration(seconds: 3), () {
//       // 延迟3s后隐藏
//       if (mounted) {
//         setState(() {
//           _playControlOpacity = 0;
//           Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
//             _hidePlayControl = true;
//           });
//         });
//       }
//     });
//   }

//   void _toggleFullScreen() {
//     // setState(() {
//     // if (_isFullScreen) {
//     //   // 如果是全屏就切换竖屏
//     //   OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
//     // } else {
//     //   OrientationPlugin.forceOrientation(DeviceOrientation.landscapeRight);
//     // }
//     // _startPlayControlTimer(); // 操作完控件开始计时隐藏
//     // });
//   }
// }
