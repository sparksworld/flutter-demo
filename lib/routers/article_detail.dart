import 'package:flutterdemo/module.dart';
import 'package:flutterdemo/routers/index.dart';

class ArticleDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailState();
  }
}

class _ArticleDetailState extends State<ArticleDetail> {
  bool _webviewloading;

  @override
  void initState() {
    _webviewloading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListItem itemData = ModalRoute.of(context).settings.arguments;
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
          //   _webviewloading
          //       ? SizedBox(
          //           width: 12.0.px,
          //           height: 12.0.px,
          //           child: Center(
          //             child: CircularProgressIndicator(
          //               strokeWidth: 1.0,

          //               backgroundColor: Colors.white,
          //               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          //             ),
          //           ),
          //         )
          //       : Container()
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
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'https://ssr.qukantx.com/qk_app/' +
                    itemData.taskId.toString(),
                onPageFinished: (String url) {
                  setState(() {
                    _webviewloading = false;
                  });
                },
              ),
            ),
          ),
          // Offstage(
          //   offstage: !_webviewloading,
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
}
