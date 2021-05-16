import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/global/Helper.dart';
import 'package:flutter_web/http/API.dart';
import 'package:flutter_web/model/UserList.dart';
import 'package:flutter_web/pages/SignUpPage.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/web/login';

  final String title;

  const LoginPage(this.title);

  static Future show(BuildContext context, String title,onValue) {
    return Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
        fullscreenDialog: true, builder: (context) => LoginPage(title))).then(onValue);
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ValueNotifier _valueNotifier = ValueNotifier('login');

  var _idCard, _patriarchMobile;

  bool _isPost = false;

  @override
  Widget build(BuildContext context) {
    Widget _firstChild = Container(
      width: 160,
      height: 40,
      margin: margin(),
      child: ElevatedButton(
        onPressed: () {
          login();
        },
        child: Text('登录报名系统'),
      ),
    );

    Widget _secondChild = Container(
      padding: EdgeInsets.all(4.0),
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: const AlwaysStoppedAnimation<Color>(themeColor),
      ),
      width: 50.0,
      height: 50.0,
    );

    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 200,
        height: double.infinity,
        margin: margin(),
        decoration: radius(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 0,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.asset('assets/login_top.png'),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      height: 0,
                    ),
                    flex: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 0,
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: buildCommonEdit(
                        context: context,
                        labelText: '请输入幼儿身份证号',
                        maxLength: 18,
                        maxLines: 1,
                        valueNotifier: _valueNotifier,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _idCard = value;
                        }),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      height: 0,
                    ),
                    flex: 2,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 0,
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: buildCommonEdit(
                        context: context,
                        labelText: '请输入报名时预留的电话',
                        maxLength: 11,
                        maxLines: 1,
                        valueNotifier: _valueNotifier,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _patriarchMobile = value;
                        }),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      height: 0,
                    ),
                    flex: 2,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              AnimatedCrossFade(
                  firstChild: _firstChild,
                  secondChild: _secondChild,
                  crossFadeState: _isPost
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(seconds: 1)),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (_isPost) {
      return;
    }

    setState(() {
      _isPost = true;
    });

    _success(result) {
      UserItem user = UserItem.fromJson(result);
      Navigator.of(context).pop(user);
    }

    _failure(error) {
      setState(() {
        _isPost = false;
      });
    }

    KinderUser.login(_idCard, _patriarchMobile)
        .then(_success)
        .catchError(_failure);
  }
}
