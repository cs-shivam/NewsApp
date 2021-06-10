import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/widgets/webview_controller_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../main.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState(this.url);
}
class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();
  bool _isLoadingPage;
  Completer<WebViewController> _controller = Completer<WebViewController>();
  _WebViewContainerState(this._url);

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }

  @override
  Widget build(BuildContext context) {
    logger.i('Info Log');
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
                  //child: CircularProgressIndicator(),
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
    );
  }
}