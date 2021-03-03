//// Copyright 2018 The Flutter team. All rights reserved.
//// Use of this source code is governed by a BSD-style license that can be
//// found in the LICENSE file.
//
//import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';
//import 'package:flutter_youtube_view/flutter_youtube_view.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'My YouTube',
//      debugShowCheckedModeBanner: false,
//      home: Scaffold(
////        appBar: AppBar(
////          title: Text('My YouTube'),
////        ),
//        body: FlutterYoutubeView(
//            //onViewCreated: _onYoutubeCreated,
//            //listener: this,
//            scaleMode: YoutubeScaleMode.none, // <option> fitWidth, fitHeight
//            params: YoutubeParam(
//                videoId: 'gcj2RUWQZ60',
//                showUI: false,
//                startSeconds: 0.0, // <option>
//                autoPlay: false) // <option>
//        )
//      ),
//      );
//  }
//}

//
//WebView(initialUrl: "https://m.youtube.com/",
//javascriptMode: JavascriptMode.unrestricted,
//)


import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home', url: 'https://m.youtube.com/'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.url});

  final String title;
  final String url;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
  Completer<WebViewController>();
  //Make sure this function return Future<bool> otherwise you will get an error
  Future<bool> _onWillPop(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
            child: WebView(
              key: UniqueKey(),
              onWebViewCreated: (WebViewController webViewController) {
                _controllerCompleter.future.then((value) => _controller = value);
                _controllerCompleter.complete(webViewController);
              },
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.url,
            )),
      ),
    );
  }
}