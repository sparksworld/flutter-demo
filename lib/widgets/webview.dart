import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyWebView extends StatefulWidget {
  String title;
  String url;
  Function onLoadStart;
  Function onLoadStop;
  Function onWebViewCreated;

  MyWebView({
    this.title,
    @required this.url,
    
  });
  @override
  State<StatefulWidget> createState() {
    return _MyWebViewState();
  }
}

class _MyWebViewState extends State<MyWebView> {
  InAppWebViewController webview;
  String _title;

  @override
  void initState() {
    _title = widget.title ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrl: widget.url,
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          debuggingEnabled: true,
          useShouldOverrideUrlLoading: true,
          useOnLoadResource: true,
          verticalScrollBarEnabled: false,
          horizontalScrollBarEnabled: false,
        ),
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        webview = controller;
        widget.onWebViewCreated(controller);
      },
      onLoadResource: (
        InAppWebViewController controller,
        LoadedResource loadedResource,
      ) async {
        String t = await webview.getTitle();
        setState(() {
          this._title = widget.title?? t;
        });
      },
      onLoadStart: (InAppWebViewController controller, String url) async {
        // setState(() {
        //   this._webviewLoading = true;
        //   this._pageLoading = false;
        // });
        print('Page started loading: $url');
      },
      onLoadStop: (InAppWebViewController controller, String url) {
        print('Page finished loading: $url');
      },
    );
  }
}
