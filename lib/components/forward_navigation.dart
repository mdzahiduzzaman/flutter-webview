import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ForwardNavigation extends StatelessWidget {
  final Future<WebViewController> controllerFuture;
  const ForwardNavigation(this.controllerFuture, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: controllerFuture,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return forwardBtn(context, controller);
          }

          return Container();
        });
  }

  IconButton forwardBtn(
      BuildContext context, AsyncSnapshot<WebViewController> controller) {
    return IconButton(
        icon: Icon(
          Icons.arrow_forward_ios,
          size: 18.0,
          color: Colors.black,
        ),
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
}
