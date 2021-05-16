import 'package:flutter/material.dart';
import 'package:flutter_web/global/Responsive.dart';
import 'package:flutter_web/pages/BodyPage.dart';
import 'package:flutter_web/pages/LoginPage.dart';
import 'package:flutter_web/pages/NoticeListPage.dart';
import 'package:flutter_web/pages/SignUpPage.dart';
import 'package:flutter_web/pages/StatisticsPage.dart';

import '../global/Helper.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/web/home';

  HomePage({required this.title});

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _child = NoticeListPage('title');

  _handleSignUp() {
    _child = SignUpPage(null);
    setState(() {});
  }

  _handleNotice() {
    _child = NoticeListPage('报名系统公告');
    setState(() {});
  }

  _handleModify(){
    LoginPage.show(context, '登录报名系统', (onValue){
      if(onValue != null){
        _child = SignUpPage(onValue);
        setState(() {});
      }else{
        debugPrint('登录失败了');
      }
    });
  }

  _handleStatistics() {
    _child = StatisticsPage('报名结果统计');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Responsive(
          mobile: Container(
            width: 100,
            height: 500,
            color: Colors.yellow,
          ),
          tablet: Container(
            width: 100,
            height: 800,
            color: Colors.orange,
          ),
          desktop: Container(
            width: double.infinity,
            height: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: margin(),
                    height: double.infinity,
                    decoration: radius(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        addToSizeBox(
                          TextButton(
                              onPressed: () {
                                _handleNotice();
                              }, child: menuItem('报名通知及公告')),
                        ),
                        addToSizeBox(
                          TextButton(onPressed: () {

                          }, child: menuItem('报名流程')),
                        ),
                        addToSizeBox(
                          TextButton(onPressed: () {
                            _handleSignUp();
                          }, child: menuItem('报名填表')),
                        ),
                        addToSizeBox(
                          TextButton(onPressed: () {
                            _handleModify();
                          }, child: menuItem('修改信息')),
                        ),
                        addToSizeBox(
                          TextButton(
                              onPressed: () {
                                _handleStatistics();
                              }, child: menuItem('查看报名结果')),
                        )
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: BodyPage(
                    child: _child,
                  ),
                  flex: 5,
                )
              ],
            ),
          )),
    );
  }
}
