import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview/components/back_navigation.dart';
import 'package:flutter_webview/components/forward_navigation.dart';

import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sheba Plus',
      theme: ThemeData(
        primaryColor: Colors.grey.shade600,
      ),
      themeMode: ThemeMode.light,
      home: MyHomePage(title: 'Sheba Plus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final globalKey = GlobalKey<ScaffoldState>();
  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: BackNavigation(controller.future),
        actions: <Widget>[
          ForwardNavigation(controller.future),
        ],
      ),
      body: WebView(
        initialUrl: 'http://epharma.essential-infotech.net/',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          controller.complete(webViewController);
        },
      ),
    );
  }
}
