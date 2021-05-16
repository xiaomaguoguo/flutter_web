import 'package:flutter/material.dart';
import 'package:flutter_web/global/Helper.dart';
import 'package:flutter_web/pages/StatisticsDetailPage.dart';

class StatisticsPage extends StatefulWidget {
  static const String routeName = '/web/statistics';

  StatisticsPage(this.title);

  final String title;

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: radius(),
          margin: margin(),
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                tjCell(() {
                  StatisticsDetailPage.show(context, 'aaaa');
                }, '临夏市学前教育中心', 105),
                tjCell(() {}, '临夏市第一幼儿园', 205),
                tjCell(() {}, '临夏市第二幼儿园', 300),
                tjCell(() {}, '临夏市第三幼儿园', 340),
                tjCell(() {}, '临夏市第四幼儿园', 209),
                tjCell(() {}, '临夏市第五幼儿园', 230),
                tjCell(() {}, '临夏市实验幼儿园', 111),
              ],
            ),
          )),
    );
  }
}
