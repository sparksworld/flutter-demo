import 'package:flutterdemo/module.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ActivityPage extends StatefulWidget {
  final Function callback;
  final arguments;
  ActivityPage({Key key, this.callback, this.arguments}) : super(key: key);

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
  GlobalKey key = GlobalKey();
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
              onPressed: () async => {
                // _controller.loadUrl(_initialUrl),
                await _controller.evaluateJavascript(
                    'Toaster.postMessage("User Agent: " + navigator.userAgent);')
                // _toasterJavascriptChannel(context)
              },
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
            child: Builder(
              builder: (BuildContext context) {
                return WebView(
                    key: key,
                    initialUrl: _initialUrl,
                    debuggingEnabled: true,
                    javascriptMode: JavascriptMode.unrestricted,
                    javascriptChannels: <JavascriptChannel>[
                      _toasterJavascriptChannel(context),
                    ].toSet(),
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller = webViewController;

                      setState(() {
                        _pageLoading = true;
                        _webviewLoading = true;
                      });
                    },
                    onPageStarted: (url) async {
                      setState(() {
                        _webviewLoading = false;
                        _pageLoading = true;
                        // _lineProgress =
                        this._timerCancel();
                        _timer =
                            Timer.periodic(Duration(milliseconds: 60), (timer) {
                          if (_lineProgress < 0.8) {
                            setState(() {
                              _lineProgress += 0.05;
                            });
                          }
                        });
                      });
                    },
                    onPageFinished: (url) {
                      _controller.getTitle().then(
                            (value) => {
                              setState(() {
                                _timerCancel();
                                _title = value;
                                _lineProgress = 1;
                                _pageLoading = false;
                              })
                            },
                          );
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

                      if (_oldHost == _host && _oldPath != _path) {
                        GlobalKey _key = GlobalKey();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActivityPage(
                                      arguments: url,
                                      key: _key,
                                    )));
                        return NavigationDecision.prevent;
                      }
                      return NavigationDecision.navigate;
                    });
              },
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

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              content: Text(message.message)
            ),
          );
        });
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
