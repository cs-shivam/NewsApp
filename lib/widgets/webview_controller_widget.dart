import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewControls extends StatelessWidget {
  const WebviewControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon:  Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady ? null : () => _controlview(context, controller, goBack: true),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded),
              onPressed: !webViewReady ? null : () => _controlview(context, controller, goBack: false),
              ),
          ],
        );
      },
    );
  }

  _controlview(BuildContext context, WebViewController controller, {bool goBack: false}) async {
    bool canNavigate = goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      if(goBack){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Reached the last page!")),
        );
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No more forward pages!")),
        );
      }
    }
  }
}