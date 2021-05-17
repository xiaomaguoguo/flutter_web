import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web/model/NoticeList.dart';
import 'package:flutter_web/model/UserList.dart';
import 'package:flutter_web/utils/Date.dart';

const themeColor = Colors.brown;
const bgColor = Colors.white;
const int pageSize = 20;

void tip(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    duration: Duration(milliseconds: 2000),
    behavior: SnackBarBehavior.floating,
    // margin: EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 200.0),
    // margin: EdgeInsets.all(20.0),
  ));
}

String sex(String idCard) {
  return '女';
}

const indicator = SizedBox(
  child: CircularProgressIndicator(
    strokeWidth: 2.0,
    valueColor: const AlwaysStoppedAnimation<Color>(themeColor),
  ),
  width: 14.0,
  height: 14.0,
);

//统计cell
Widget tjCell(_tap, String name, int count) {
  return Container(
    width: 300,
    height: 180,
    margin: margin(),
    decoration: radius(radius: 8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '已报名:$count人',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: _tap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 10.0,
              ),
              child: menuItem('查看详情', fontSize: 14, color: Colors.white),
            ))
      ],
    ),
  );
}

Decoration radius(
    {double borderWidth = 2.0,
    double radius = 20.0,
    Color color = Colors.white}) {
  return BoxDecoration(
      border: new Border.all(color: Colors.grey, width: borderWidth),
      color: color,
      borderRadius: new BorderRadius.circular((radius)));
}

EdgeInsetsGeometry margin() {
  return EdgeInsets.all(8);
}

TextStyle tipStyle() {
  return TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red);
}

Widget addToSizeBox(Widget child, {double height = 60, double width = 200}) {
  return SizedBox(
    height: height,
    width: width,
    child: child,
  );
}

Widget menuItem(String text,
    {double fontSize = 18.0, Color color = Colors.black}) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, color: color),
  );
}

Widget rowTitle(text) {
  return Container(
    child: Text(
      text,
      style: TextStyle(fontSize: 18),
    ),
    alignment: Alignment.centerRight,
  );
}

Widget rowUserTitle(title, title1, title2, title3, title4) {
  return Container(
    width: 200,
    height: 80,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            rowBody(
              title,
            ),
            rowBody(title1),
            rowBody(title2),
            rowBody(title3),
            rowBody(title4),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 0.5,
          color: Colors.grey,
        ),
      ],
    ),
  );
}

Widget rowContent(int index, UserItem userItem) {
  return Container(
    height: 70,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            rowBody('$index'),
            rowBody(userItem.idName),
            rowBody(sex(userItem.idCard)),
            rowBody(userItem.idCard),
            rowBody(userItem.nationName),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 0.5,
          color: Colors.grey,
        ),
      ],
    ),
  );
}

Widget noticeItem(NoticeItem noticeItem, onTap) {
  return Container(
    margin: margin(),
    height: 100,
    child: Expanded(
      child: TextButton(
        style: TextButton.styleFrom(alignment: Alignment.centerLeft),
        onPressed: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              noticeItem.title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              noticeItem.content,
              maxLines: 1,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              '发布时间:${convertDate(noticeItem.createTime)}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Container(
              height: 10.0,
            ),
            Divider(
              height: 0.5,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget rowBody(String index) {
  return Expanded(
    child: Container(
      width: double.infinity,
      height: 50,
      child: Center(
        child: Text(
          index,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    ),
    flex: 1,
  );
}

Widget buildCommonEdit(
    {context,
    labelText,
    controller,
    required ValueNotifier valueNotifier,
    maxLines,
    maxLength,
    bool digitsOnly = false,
    keyboardType,
    onChanged,
    Color color = Colors.black45}) {
  if (controller != null) {
    valueNotifier.value = controller.text;
  }
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
    child: TextField(
      onChanged: (str) {
        valueNotifier.value = str;
        onChanged(str);
      },
      controller: controller,
      cursorColor: color,
      decoration: InputDecoration(
          hintText: labelText,
          // labelText: labelText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: color, width: 0.2),
          ),
          labelStyle: TextStyle(color: color, fontSize: 16)),
      maxLines: maxLines,
      maxLength: maxLength,
      buildCounter:
          (_, {required currentLength, maxLength, required isFocused}) => null,
      //键盘类别
      keyboardType: keyboardType,
      //只能输入数字
      inputFormatters: digitsOnly
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : <TextInputFormatter>[],
      onSubmitted: (text) {
//        FocusScope.of(context).requestFocus(node);
      },
    ),
  );
}
