import 'package:flutterdemo/module.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  double _logoSize = 60.0;
  num _time = 4000;

  startTime() async {
    var _duration = new Duration(milliseconds: _time + 1000);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return new FadeTransition(
            //使用渐隐渐入过渡,
            opacity: animation,
            child: MyHome(tabActiveIndex: 0), //路由B
          );
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    controller = new AnimationController(
        duration: Duration(milliseconds: _time), vsync: this);
    animation = new Tween(begin: _logoSize, end: 200.0).animate(controller)
      ..addListener(() {
        setState(() {
          _logoSize = animation.value; 
        });
      });
    controller.forward();
    startTime();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FlutterLogo(
            size: _logoSize,
          ),
        ),
      ),
    );
  }
}
