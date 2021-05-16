import 'package:flutter/material.dart';
import 'package:flutter_web/global/Helper.dart';

class ResultPage extends StatefulWidget {
  static const String routeName = '/web/result';

  final String title;

  const ResultPage(this.title);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.orange,
      decoration: radius(),
      child: Column(
        children: [
          Text('您是第1位报名者'),
          Text('恭喜您,报名成功!'),
          Text('请牢记您的查询码:234289'),
        ],
      ),
    );
  }
}
