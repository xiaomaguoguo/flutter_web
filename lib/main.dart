import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_web/pages/LoginPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'pages/LaunchPage.dart';
import 'pages/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => ClassicHeader(
        completeText: '加载完成',
        failedText: '加载失败,请稍后再试',
        idleText: '下拉刷新列表',
        releaseText: '松开刷新列表',
        refreshingText: '刷新中...',
      ),
      // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
      footerBuilder: () => ClassicFooter(
        noDataText: '没有更多',
        idleText: '松开加载更多数据',
        failedText: '加载失败,请稍后再试',
        loadingText: '加载中...',
      ),
      // Configure default bottom indicator
      headerTriggerDistance: 80.0,
      // header trigger refresh trigger distance
      springDescription:
      SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      // custom spring back animate,the props meaning see the flutter api
      maxOverScrollExtent: 100,
      //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
      maxUnderScrollExtent: 0,
      // Maximum dragging range at the bottom
      enableScrollWhenRefreshCompleted: true,
      //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
      enableLoadingWhenFailed: true,
      //In the case of load failure, users can still trigger more loads by gesture pull-up.
      hideFooterWhenNotFull: false,
      // Disable pull-up to load more functionality when Viewport is less than one screen
      enableBallisticLoad: true,
      child: MaterialApp(
        title: '临夏市幼儿园报名系统',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
//      home: LaunchPage(),
        home: HomePage(title: '临夏市幼儿园报名系统',),
        routes: {
          HomePage.routeName: (ctx) => HomePage(title: '测试呀',),
        },
      ),
    );
  }
}
