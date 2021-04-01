import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  final Future<WebViewController> controllerFuture;
  const NavigationControls(this.controllerFuture, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: controllerFuture,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return Row(
              children: <Widget>[
                backBtn(context, controller),
                refreshBtn(controller),
                forwardBtn(context, controller),
              ],
            );
          }

          return Container();
        });
  }

  IconButton refreshBtn(AsyncSnapshot<WebViewController> controller) {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () => controller.data.reload(),
    );
  }

  IconButton forwardBtn(
      BuildContext context, AsyncSnapshot<WebViewController> controller) {
    return IconButton(
        icon: Icon(Icons.arrow_forward),
        onPressed: () async {
          if (await controller.data.canGoForward()) {
            controller.data.goForward();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'No page(s) to go forward to',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            );
          }
        });
  }

  IconButton backBtn(
      BuildContext context, AsyncSnapshot<WebViewController> controller) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () async {
          if (await controller.data.canGoBack()) {
            controller.data.goBack();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'No page(s) to go back to',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            );
          }
        });
  }
}
