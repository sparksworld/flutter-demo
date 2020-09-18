import 'package:flutterdemo/module.dart';
import 'package:flutterdemo/routers/index.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ArticleDetail extends StatefulWidget {
  final arguments;
  ArticleDetail({this.arguments});
  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailState();
  }
}

class _ArticleDetailState extends State<ArticleDetail> {
  bool _webviewloading;
  bool _pageLoading;
  InAppWebViewController _controller;
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();

  @override
  void initState() {
    _webviewloading = true;
    _pageLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context));
    ListItem itemData = widget.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(itemData.tTitle),
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
        actions: [
          _webviewloading
              ? UnconstrainedBox(
                  child: SizedBox(
                    width: 60.0.px,
                    height: 24.0.px,
                    child: Center(
                      child: Container(
                        width: 24.px,
                        height: 24.px,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Offstage(
            offstage: false,
            child: Container(
              color: Colors.white,
              child: InAppWebView(
                initialUrl: 'https://ssr.qukantx.com/qk_app/' +
                    itemData.taskId.toString(),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    debuggingEnabled: true,
                    verticalScrollBarEnabled: false,
                    horizontalScrollBarEnabled: false
                    // scrollBarStyle: ''
                  ),
                ),
                onWebViewCreated: (InAppWebViewController webViewController) {
                  _controller = webViewController;
                },
                onLoadStart: (InAppWebViewController webViewController,
                    String url) async {
                  setState(() {
                    _webviewloading = true;
                    _pageLoading = false;
                  });
                },
                onLoadStop:
                    (InAppWebViewController webViewController, String url) {
                  setState(() {
                    _webviewloading = false;
                  });
                },
              ),
            ),
          ),
          Offstage(
            offstage: !_pageLoading,
            child: Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
