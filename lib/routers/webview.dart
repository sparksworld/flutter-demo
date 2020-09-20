import 'package:flutterdemo/module.dart';


// void main() => runApp(MaterialApp(home: WebViewPage()));

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.cn/">https://www.google.cn/</a></ul>
</ul>
</body>
</html>
''';

class WebViewPage extends StatefulWidget {
  String arguments;
  WebViewPage({
    Key key,
    this.arguments,
  }) : super(key: key);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController _controller;
  bool _loading;
  bool _webviewloading;
  String _title = "";
  double _progress;

  @override
  void initState() {
    _loading = true;
    _webviewloading = true;
    _title = '加载中...';
    _progress = 0.0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        bottom: _webviewloading
            ? PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: LinearProgressIndicator(
                  minHeight: 2.0.px,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).buttonColor),
                ),
              )
            : PreferredSize(
                child: Container(),
                preferredSize: Size.fromHeight(0),
              ),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        // actions: <Widget>[
        //   NavigationControls(_controller.future),
        //   SampleMenu(_controller.future),
        // ],
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return Stack(
          children: [
            InAppWebView(
              initialUrl: widget.arguments,
              // javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (InAppWebViewController webViewController) {
                _controller = webViewController;
              },

              // javascriptChannels: <JavascriptChannel>[
              //   _toasterJavascriptChannel(context),
              // ].toSet(),
              // navigationDelegate: (NavigationRequest request) {
              //   String _old_host = Uri.parse(widget.arguments).host;
              //   String _old_path = Uri.parse(widget.arguments).path;
              //   String _host = Uri.parse(request.url).host;
              //   String _path = Uri.parse(request.url).path;

              //   if (_old_host == _host && _old_path != _path) {
              //     Navigator.pushNamed(context, '/webview',
              //         arguments: request.url);
              //     return NavigationDecision.prevent;
              //   }
              //   return NavigationDecision.navigate;
              //   // if (request.url.startsWith('https://www.youtube.com/')) {
              //   //   print('blocking navigation to $request}');
              //   // }
              //   // print('allowing navigation to $request');
              // },
              onLoadStart:
                  (InAppWebViewController controller, String url) async {
                setState(() {
                  _webviewloading = true;
                  _loading = false;
                });
                print('Page started loading: $url');
              },
              onLoadStop:
                  (InAppWebViewController controller, String url) async {
                // RegExp reg = new RegExp(r'^\"(.*)\"$');
                // var controller = await _controller.future;
                // String title =
                //     await controller.evaluateJavascript("document.title");
                // setState(() {
                //   _webviewloading = false;
                //   _title = title.replaceAllMapped(reg, (m) => '${m[1]}');
                // });

                print('Page finished loading: $url');
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this._progress = progress / 100;
                });
              },
              androidShouldInterceptRequest: (InAppWebViewController controller,
                  WebResourceRequest webResourceRequest) {
                print(webResourceRequest);
              },
            ),
            Offstage(
              offstage: !_loading,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  //   return JavascriptChannel(
  //       name: 'Toaster',
  //       onMessageReceived: (JavascriptMessage message) {
  //         Scaffold.of(context).showSnackBar(
  //           SnackBar(content: Text(message.message)),
  //         );
  //       });
}
