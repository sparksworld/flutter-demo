import 'package:flutterdemo/module.dart';
class ActivityPage extends StatefulWidget {
  final Function callback;
  ActivityPage({this.callback});

  @override
  State<StatefulWidget> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  WebViewController _controller;
  var _title = "";

  @override
  Widget build(BuildContext context) {
    return CommonHeader(
      title: Text(_title),
      body: WebView(
          initialUrl: 'http://blog.fe-spark.cn',
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
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            _controller.evaluateJavascript("document.title").then((result) {
              print(result);
              setState(() {
                _title = result;
              });
            });
          },
          gestureNavigationEnabled: true,
        )
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
