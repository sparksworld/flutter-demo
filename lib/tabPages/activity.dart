import 'package:flutterdemo/module.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ActivityPage extends StatefulWidget {
  final Function callback;
  ActivityPage({this.callback});

  @override
  State<StatefulWidget> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  InAppWebViewController _controller;
  // FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  bool _webviewLoading;
  bool _pageLoading;
  bool _webviewError;
  double _lineProgress;
  String _title;
  String _initialUrl = 'http://blog.fe-spark.cn/';

  @override
  void initState() {
    _webviewLoading = true;
    _pageLoading = true;
    _webviewError = false;

    _lineProgress = 0.0;
    _title = "";

    super.initState();
  }

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
            onPressed: () => {_controller?.loadUrl(url: _initialUrl)},
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
          // Container(
          //   child: Center(
          //     child: Text('加载失败'),
          //   ),
          // ),
          Offstage(
            offstage: _webviewLoading,
            child: InAppWebView(
              initialUrl: _initialUrl,
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  debuggingEnabled: true,
                  useShouldOverrideUrlLoading: true,
                  useOnLoadResource: true,
                  verticalScrollBarEnabled: false,
                  horizontalScrollBarEnabled: false,
                ),
              ),
              onWebViewCreated: (InAppWebViewController webViewController) {
                _controller = webViewController;
              },
              onLoadResource: (
                InAppWebViewController controller,
                LoadedResource loadedResource,
              ) async {
                String t = await _controller.getTitle();
                setState(() {
                  this._title = t;
                });
              },
              onLoadStart:
                  (InAppWebViewController controller, String url) async {
                setState(() {
                  this._webviewLoading = true;
                  this._pageLoading = false;
                });
                print('Page started loading: $url');
              },
              onLoadStop: (InAppWebViewController controller, String url) {
                print('Page finished loading: $url');
                setState(() {
                  this._webviewLoading = false;
                });
              },
              shouldOverrideUrlLoading: (
                InAppWebViewController controller,
                ShouldOverrideUrlLoadingRequest shouldOverrideUrlLoadingRequest,
              ) async {
                // String _old_host = Uri.parse(_initialUrl).host;
                // String _old_path = Uri.parse(_initialUrl).path;
                // String _host =
                //     Uri.parse(shouldOverrideUrlLoadingRequest.url).host;
                // String _path =
                //     Uri.parse(shouldOverrideUrlLoadingRequest.url).path;
                // print(shouldOverrideUrlLoadingRequest.url);
                if (shouldOverrideUrlLoadingRequest.url != _initialUrl) {
                  Navigator.pushNamed(
                    context,
                    '/in_app_webview',
                    arguments: shouldOverrideUrlLoadingRequest.url,
                  );
                  return ShouldOverrideUrlLoadingAction.CANCEL;
                }
                return ShouldOverrideUrlLoadingAction.ALLOW;
              },
            ),
          ),

          Offstage(
            offstage: !_pageLoading,
            child: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
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
