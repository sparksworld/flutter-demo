import 'package:flutterdemo/module.dart';

class MyWebView extends StatefulWidget {
  String url;
  Function onWebViewCreated;
  Function onLoadStart;
  Function onLoadStop;

  MyWebView({
    @required this.url,
  });
  @override
  State<StatefulWidget> createState() {
    return _MyWebViewState();
  }
}

class _MyWebViewState extends State<MyWebView> {
  InAppWebViewController webview;

  @override
  void initState() {
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
            // verticalScrollBarEnabled: false,
            // horizontalScrollBarEnabled: false,
            javaScriptCanOpenWindowsAutomatically: true,
          ),
          android: AndroidInAppWebViewOptions(
            supportMultipleWindows: true,
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webview = controller;
          // webview.injectCSSCode(source: """
          //   *::-webkit-scrollbar {
          //       /*滚动条整体样式*/
          //       width: 8px;/*定义纵向滚动条宽度*/
          //       height: 8px;/*定义横向滚动条高度*/
          //   }

          //   *::-webkit-scrollbar-thumb {
          //       /*滚动条内部滑块*/
          //       border-radius: 8px;
          //       background-color: hsla(220, 4%, 58%, 0.3);
          //       transition: background-color 0.3s;
          //   }

          //   *::-webkit-scrollbar-thumb:hover {
          //       /*鼠标悬停滚动条内部滑块*/
          //       background: #bbb;
          //   }

          //   *::-webkit-scrollbar-track {
          //       /*滚动条内部轨道*/
          //       background: #ededed;
          //   }
          //  """);
          widget.onWebViewCreated(controller);
        },
        onLoadResource: (
          InAppWebViewController controller,
          LoadedResource loadedResource,
        ) async {
          String t = await webview.getTitle();
          // setState(() {
          //   this._title = widget.title ?? t;
          // });
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
        // 支持下载
        androidOnPermissionRequest: (InAppWebViewController controller,
            String origin, List<String> resources) async {
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT,
          );
        });
  }
}
