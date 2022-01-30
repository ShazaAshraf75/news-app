// ignore_for_file: must_be_immutable, empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  late String url;
  WebviewScreen(this.url, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Page"),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
