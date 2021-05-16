import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/global/Helper.dart';
import 'package:flutter_web/model/NoticeList.dart';

class NoticeDetailPage extends StatefulWidget {
  static const String routeName = '/web/notice-detail';

  final NoticeItem notice;

  NoticeDetailPage(this.notice);

  static Future show(BuildContext context, NoticeItem notice) {
    return Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
        fullscreenDialog: true, builder: (context) => NoticeDetailPage(notice)));
  }

  @override
  _NoticeDetailPageState createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Material(type: MaterialType.transparency,child: Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: radius(),
        margin: margin(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  widget.notice.title,
                  style: TextStyle(fontSize: 40, color: Colors.black),
                ),
              ),
              Text(
                '临市教发[2021]103号',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  widget.notice.content,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    ),);
  }
}
