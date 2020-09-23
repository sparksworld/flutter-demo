import 'package:flutterdemo/module.dart';

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
  // InAppWebViewController _controller;
  WebViewController _controller;

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
              child: WebView(
                initialUrl: 'https://ssr.qukantx.com/qk_app/' +
                    itemData.taskId.toString(),
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                },
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (String url) async {
                  setState(() {
                    _webviewloading = true;
                    _pageLoading = false;
                  });
                },
                onPageFinished:
                    (String url) {
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
