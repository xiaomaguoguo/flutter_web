import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/utils/ImageLoader.dart';

import '../http/API.dart';
import '../model/AdsList.dart';
import 'HomePage.dart';

/// 启动页
class LaunchPage extends StatefulWidget {
  static const String routeName = '/launcher';

  static void show(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
        fullscreenDialog: false, builder: (context) => LaunchPage()));
  }

  @override
  State<StatefulWidget> createState() {
    return LaunchState();
  }
}

class LaunchState extends State<LaunchPage> {

  late Timer _timer;

  late AdsItem _adsItem;

  @override
  void initState() {
    super.initState();

    // 获取广告数据
    _getADList();

    _timer = Timer(Duration(seconds: 3), () {
      _timer.cancel();
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    });

  }

  _getADList() {
    Ads.banners(type: 0).then((result) {
      var list = result as List;
      List<AdsItem> newList = list.map((i) => AdsItem.fromJson(i)).toList();
      if (newList != null && newList.isNotEmpty) {
        _adsItem = newList[0];
        setState(() {});
      }
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.only(bottom: 8.0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: _adsItem == null
                    ? Container()
                    : Container(
                        width: double.infinity,
                        child: loadImage(
                            isIconHolder: false,
                            imageUrl: _adsItem.cover,
                            fit: BoxFit.fill),
                      ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset('assets/login_logo.jpg'),
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '牛逼Plus',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        Text('努力就好,不要想太多',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black45)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
