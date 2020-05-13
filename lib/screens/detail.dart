import 'package:flutter/material.dart';
import 'package:flutterusers/network/user.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';




class Detail extends StatefulWidget {
  final User user;
  Detail(this.user);
  @override
  State createState() => _detailPageState(this.user);
}

class _detailPageState extends State {
  User user;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  _detailPageState(this.user);
  @override
  void initState() {
    super.initState();
  } 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(this.user.username),
        automaticallyImplyLeading: true,
         iconTheme: IconThemeData(
         color: Colors.white
       ),
      ),
      body: Scaffold(
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: this.user.html_url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _controller.complete(controller);
  
            },
            onPageStarted: (String url) {
            print('Page started loading: $url');
             Toast.show('Page Loading Please wait', context, 
             duration: Toast.LENGTH_SHORT,
              gravity:  Toast.BOTTOM,
              backgroundColor: Color(0xff3E64FF),
              textColor: Colors.white
      );
          },
          );
        })
      ),
    );
  }
}
