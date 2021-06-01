import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BackNavigation extends StatelessWidget {
  final Future<WebViewController> controllerFuture;
  const BackNavigation(this.controllerFuture, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: controllerFuture,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return backBtn(context, controller);
          }

          return Container();
        });
  }

  IconButton backBtn(
      BuildContext context, AsyncSnapshot<WebViewController> controller) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          size: 18.0,
          color: Colors.black,
        ),
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
