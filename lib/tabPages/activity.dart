import 'package:flutterdemo/module.dart';

class ActivityPage extends StatefulWidget {
  final Function callback;
  ActivityPage({this.callback});

  @override
  State<StatefulWidget> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  WebViewController _controller;
  // FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  bool _webviewLoading = true;
  bool _webviewError = false;
  double _lineProgress = 0.0;
  String _title = "";
  String _initialUrl = 'http://blog.fe-spark.cn';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => {_controller?.reload()},
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => {_controller?.loadUrl(_initialUrl)},
          ),
        ],
        bottom: PreferredSize(
          child: _progressBar(_lineProgress, context),
          preferredSize: Size.fromHeight(1.0.rpx),
        ),
      ),
      // Offstage
      body: Stack(
        alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
        children: <Widget>[
          Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          // Container(
          //   child: Center(
          //     child: Text('加载失败'),
          //   ),
          // ),
          Offstage(
            offstage: _webviewLoading,
            child: WebView(
              initialUrl: _initialUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                // _controller.complete(webViewController);
                _controller = webViewController;
              },
              // TODO(iskakaushik): Remove this when collection literals makes it to stable.
              // ignore: prefer_collection_literals
              // javascriptChannels: <JavascriptChannel>[
              //   _toasterJavascriptChannel(context),
              // ].toSet(),
              navigationDelegate: (NavigationRequest request) {
                // if (request.url.startsWith('http://blog.fe-spark.cn')) {
                //   print('blocking navigation to $request}');
                //   return NavigationDecision.prevent;
                // }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                setState(() {
                  this._title = '加载中...';
                  this._webviewLoading = true;
                  // lineProgress += 10;
                });
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
                _controller.evaluateJavascript("document.title").then((result) {
                  RegExp reg = new RegExp(r'^\"(.*)\"$');
                  setState(() {
                    this._webviewLoading = false;
                    this._title = result.replaceAllMapped(reg, (m) => '${m[1]}');
                  });
                });
              },
              gestureNavigationEnabled: true,
            ),
          ),

          // Positioned(
          //   top: 18.0,
          //   child: Text("Your friend"),
          // )
        ],
      ),
    );
  }

  Widget _progressBar(double progress, BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.white70.withOpacity(0),
      value: progress == 1.0 ? 0 : progress,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }
}

JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      });
}
