import 'package:flutterdemo/module.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
    var _duration = new Duration(milliseconds: _time + 1500);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // Navigator.of(context).pushReplacementNamed('/login');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => MyHome(tabActiveIndex: 1),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    controller = new AnimationController(
        duration: Duration(milliseconds: _time), vsync: this);
    animation = new Tween(begin: 0.0, end: 100.0).animate(controller)
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
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('data'),
      //   centerTitle: true
      // ),
      body: Container(
        child: Center(
            child: FlutterLogo(
          size: _logoSize,
        )),
      ),
    );
  }
}
