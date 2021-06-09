import 'package:flutter/material.dart';
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
  _WebViewContainerState(this._url);
  num position = 1 ;
 doneLoading() {
    setState(() {
      position = 0;
    });
  }
  startLoading(){
    setState(() {
      position = 1;
    });
  }
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
      ),
      body: Column(
        children: [
          LinearProgressIndicator(backgroundColor: Colors.lightBlue),
          Expanded(
            child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: _url,    
              
            )),
        ],
      )
    );
  }
}