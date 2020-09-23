import 'package:flutterdemo/module.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ActivityPage extends StatefulWidget {
  final Function callback;
  final arguments;
  ActivityPage({this.callback, this.arguments});

  @override
  State<StatefulWidget> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  // WebViewController _controller;
  WebViewController _controller;
  bool _webviewLoading;
  bool _pageLoading;
  double _lineProgress;
  String _title;
  String _initialUrl;
  Timer _timer;
  @override
  void initState() {
    _webviewLoading = true;
    _pageLoading = true;
    // _controller.future.then((value) => webView = value);
    _initialUrl = widget.arguments ?? 'http://blog.fe-spark.cn/';
    _lineProgress = 0.0;
    _title = "";
    super.initState();
  }

  @override
  void dispose() {
    this._timerCancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_title),
          actions: [
            // IconButton(
            //   icon: Icon(Icons.refresh),
            //   onPressed: () => {_controller?.reload()},
            // ),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () => {},
            ),
          ],
          bottom: PreferredSize(
            child: _progressBar(_lineProgress, context),
            preferredSize: Size.fromHeight(1.0.rpx),
          )),
      // Offstage
      body: Stack(
        alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
        children: <Widget>[
          // Container(
          //   child: Center(
          //     child: Text('加载失败'),
          //   ),
          // ),
          Offstage(
            offstage: _webviewLoading,
            child: Scrollbar(
              child: WebView(
                  initialUrl: _initialUrl,
                  debuggingEnabled: true,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                    setState(() {
                      _pageLoading = true;
                      _webviewLoading = true;
                    });
                  },
                  onPageStarted: (url) {
                    setState(() {
                      _webviewLoading = false;
                      _pageLoading = true;
                      // _lineProgress =
                      this._timerCancel();
                      _timer =
                          Timer.periodic(Duration(milliseconds: 100), (timer) {
                        if (_lineProgress < 0.8) {
                          setState(() {
                            _lineProgress += 0.05;
                          });
                        }
                      });
                    });
                  },
                  onPageFinished: (url) {
                    setState(() {
                      _lineProgress = 0.95;
                    });
                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                        this._timerCancel();
                        _pageLoading = false;
                        _lineProgress = 1.0;
                      });
                    });
                  },
                  navigationDelegate:
                      (NavigationRequest navigationRequest) async {
                    var url = navigationRequest.url;
                    var uri = Uri.parse(url);
                    String _oldHost = Uri.parse(_initialUrl).host;
                    String _oldPath = Uri.parse(_initialUrl).path;
                    String _host = Uri.parse(url).host;
                    String _path = Uri.parse(url).path;

                    if (![
                      "http",
                      "https",
                      "file",
                      "chrome",
                      "data",
                      "javascript",
                      "about"
                    ].contains(uri.scheme)) {
                      if (await canLaunch(url)) {
                        // Launch the App
                        await launch(
                          url,
                        );
                        // and cancel the request
                      } else {
                        _controller
                            .evaluateJavascript("window.alert('内部错误🙅')");
                      }
                      return NavigationDecision.prevent;
                    }
                    // print(_host.contains('fe-spark'));
                    if (_oldHost == _host && _oldPath != _path) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActivityPage(
                                    arguments: navigationRequest.url,
                                  )));
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  }),
            ),
          ),

          // Offstage(
          //   offstage: !_pageLoading,
          //   child: Container(
          //     child: Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void _timerCancel() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  Widget _progressBar(double progress, BuildContext context) {
    return Container(
      child: LinearProgressIndicator(
        backgroundColor: Colors.blueAccent.withOpacity(0),
        value: progress == 1.0 ? 0 : progress,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightBlue),
      ),
      height: 1,
    );
  }
}

/**
 * @description: 
 * @param {type} 
                  var url = shouldOverrideUrlLoadingRequest.url;
                  var uri = Uri.parse(url);
                  String _oldHost = Uri.parse(_initialUrl).host;
                  String _oldPath = Uri.parse(_initialUrl).path;
                  String _host = Uri.parse(url).host;
                  String _path = Uri.parse(url).path;

                  if (![
                    "http",
                    "https",
                    "file",
                    "chrome",
                    "data",
                    "javascript",
                    "about"
                  ].contains(uri.scheme)) {
                    if (await canLaunch(url)) {
                      // Launch the App
                      await launch(
                        url,
                      );
                      // and cancel the request
                    } else {
                      _controller.evaluateJavascript("window.alert('内部错误🙅')");
                    }
                    return ShouldOverrideUrlLoadingAction.CANCEL;
                  }
                  // print(_host.contains('fe-spark'));
                  if (_oldHost == _host && _oldPath != _path) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActivityPage(
                                  arguments:
                                      shouldOverrideUrlLoadingRequest.url,
                                )));
                    return ShouldOverrideUrlLoadingAction.CANCEL;
                  }
                  return ShouldOverrideUrlLoadingAction.ALLOW;
                },
 * @return {type} 
 */
