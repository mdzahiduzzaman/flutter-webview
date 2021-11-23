import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      title: 'WebView',
      theme: ThemeData(
        primaryColor: Colors.grey.shade600,
      ),
      themeMode: ThemeMode.light,
      home: MyHomePage(title: 'Sheba Plus'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double progress = 0;
  String? currentUrl = 'https://www.google.com/';

  final globalKey = GlobalKey<ScaffoldState>();
  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  WebViewController? controllerGlobal;
  Future<bool> goBack() async {
    if (await controllerGlobal!.canGoBack()) {
      controllerGlobal!.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: goBack,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: ListTile(
              title: Text(
                'Flutter WebView',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(currentUrl!,
                  style: TextStyle(overflow: TextOverflow.ellipsis)),
              contentPadding: const EdgeInsets.all(0),
            ),
            leading: IconButton(
              padding: const EdgeInsets.only(left: 10),
              icon: Icon(Icons.clear),
              onPressed: () {
                controllerGlobal!.clearCache();
                CookieManager().clearCookies();
              },
            ),
            actions: [
              IconButton(
                padding: const EdgeInsets.only(right: 10),
                onPressed: () {
                  controllerGlobal!.reload();
                },
                icon: Icon(Icons.refresh),
              ),
            ],
            leadingWidth: 37.5,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
              ),
              Expanded(
                child: WebView(
                  initialUrl: 'https://www.google.com/',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    controller.future.then((value) => controllerGlobal = value);
                    controller.complete(webViewController);
                  },
                  onPageFinished: (url) {
                    setState(() => currentUrl = url);
                  },
                  onProgress: (progress) =>
                      setState(() => this.progress = progress / 100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
