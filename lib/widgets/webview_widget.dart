import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/widgets/webview_controller_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState(this.url);
}
// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();
  bool _isLoadingPage;
  Completer<WebViewController> _controller = Completer<WebViewController>();
  _WebViewContainerState(this._url);
 // num position = 1 ;
  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }

//  doneLoading() {
//     setState(() {
//       position = 0;
//     });
//   }
//   startLoading(){
//     setState(() {
//       position = 1;
//     });
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        elevation: 20.0,
        toolbarHeight: 50,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 30,
            ),
          ],
        ),
        actions: <Widget>[
          WebviewControls(_controller.future),
        ],
      ),
      body: Column(
        children: [
          _isLoadingPage
              ? Container(
                  alignment: FractionalOffset.center,
                  child: LinearProgressIndicator(backgroundColor: Colors.lightBlue),
                )
              : Container(
                  color: Colors.transparent,
                ),

          Expanded(
            child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: _url, 
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },   
              onPageFinished: (finish) {
              setState(() {
                _isLoadingPage = false;
              });
            },
              
            )),
        ],
      ),
    //  floatingActionButton: WebviewControls(_controller.future),
    );
  }
}