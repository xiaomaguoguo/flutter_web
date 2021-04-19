import 'dart:html';

import 'package:flutter/material.dart';

import 'global/LaunchPage.dart';
import 'global/MyHomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterWeb测试',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: LaunchPage(),
      routes: {
        MyHomePage.routeName: (ctx) => MyHomePage(title: '测试呀',),
      },
    );
  }
}
