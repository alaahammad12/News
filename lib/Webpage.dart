import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webpage extends StatelessWidget {
  var url;
  webpage(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Web page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: WebView(initialUrl: url),
    );
  }
}
