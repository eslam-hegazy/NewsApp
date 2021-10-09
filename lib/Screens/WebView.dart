import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final String? link, title;
  WebViewPage(this.link, this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$title",
          style: Theme.of(context).textTheme.body1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: link == null
              ? CircularProgressIndicator(
                  color: Colors.red,
                )
              : WebView(
                  initialUrl: "$link",
                  javascriptMode: JavascriptMode.unrestricted,
                ),
        ),
      ),
    );
  }
}
