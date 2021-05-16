import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/global/Helper.dart';
import 'package:flutter_web/http/API.dart';
import 'package:flutter_web/model/GartenList.dart';
import 'package:flutter_web/model/NationList.dart';
import 'package:flutter_web/model/UserList.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/web/sign-up';

  UserItem? _user;

  SignUpPage(this._user);

  static Future show(BuildContext context, {UserItem? user}) {
    return Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
        fullscreenDialog: false, builder: (context) => SignUpPage(user)));
  }

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _gartenList = <GartenItem>[];
  var _nationList = <NationItem>[];

  var _idName = '',
      _idCard = '',
      _reIdCard = '',
      _idGarten,
      _gartenName = '  点击此处选择幼儿园',
      _idNation,
      _nationName = '  点击此处选择幼儿民族',
      _patriarchName = '',
      _patriarchMobile = '',
      _patriarchAddress = '';

  //是否当地 0-是 1-否
  int? _typeLocal = 0, _typeJz = 0;

  String _patriarchAddressType = '自有住房';

  ValueNotifier _valueNotifier = ValueNotifier('signup');

  late Widget _firstChild, _secondChild;

  bool _isSuccess = false;

  var _idNameCtrl,
      _idCardCtrl,
      _reIdCardCtrl,
      _patriarchNameCtrl,
      _patriarchMobileCtrl,
      _patriarchAddressCtrl;

  @override
  void initState() {
    super.initState();

    if (widget._user != null) {
      _idName = widget._user!.idName;
      _idCard = widget._user!.idCard;
      _reIdCard = widget._user!.idCard;
      _typeLocal = widget._user!.typeLocal;
      _typeJz = widget._user!.typeJz;
      _patriarchName = widget._user!.patriarchName;
      _patriarchMobile = widget._user!.patriarchMobile;
      _patriarchAddress = widget._user!.patriarchAddress;
      _patriarchAddressType = widget._user!.patriarchAddressType;

      _idNameCtrl = TextEditingController(text: _idName);
      _idCardCtrl = TextEditingController(text: _idCard);
      _reIdCardCtrl = TextEditingController(text: _idCard);
      _patriarchNameCtrl = TextEditingController(text: _patriarchName);
      _patriarchMobileCtrl = TextEditingController(text: _patriarchMobile);
      _patriarchAddressCtrl = TextEditingController(text: _patriarchAddress);

      _idGarten = widget._user!.idGarten;
      _idNation = widget._user!.idNation;

      _loadDetail();
    } else {
      _idNameCtrl = TextEditingController(text: '');
      _idCardCtrl = TextEditingController(text: '');
      _reIdCardCtrl = TextEditingController(text: '');
      _patriarchNameCtrl = TextEditingController(text: '');
      _patriarchMobileCtrl = TextEditingController(text: '');
      _patriarchAddressCtrl = TextEditingController(text: '');
    }

    _loadList();
  }

  void _loadDetail() {
    KinderName.one(_idGarten).then((result) {
      GartenItem garten = GartenItem.fromJson(result);
      _idGarten = garten.id;
      _gartenName = garten.name;
      setState(() {});
    }).catchError((error) {});
    KinderNation.one(_idNation).then((result) {
      NationItem nation = NationItem.fromJson(result);
      _idNation = nation.id;
      _nationName = nation.name;
      setState(() {});
    }).catchError((error) {});
  }

  void _loadList() {
    KinderName.list().then((result) {
      var list = result as List;
      _gartenList = list.map((i) => GartenItem.fromJson(i)).toList();
    }).catchError((error) {});
    KinderNation.list().then((result) {
      var list = result as List;
      _nationList = list.map((i) => NationItem.fromJson(i)).toList();
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    _firstChild = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              '幼儿园报名-填写报名信息',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              '温馨提示:实验幼儿园为全日拖制幼儿园,小班幼儿园年龄须满3.5岁(即2018年3月1日至2019年2月28日期间出生,区间为1岁)',
              style: tipStyle(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Table(
              columnWidths: {
                1: FlexColumnWidth(3.0),
                2: FlexColumnWidth(1.0),
                3: FlexColumnWidth(3.0),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              // border: TableBorder.all(
              //   color: Colors.red,
              // ),
              children: [
                TableRow(children: [
                  rowTitle('选择幼儿园'),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: SizedBox(
                      height: 58,
                      width: 200,
                      child: OutlinedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('请选择幼儿园'),
                                  content: Container(
                                    width: 400,
                                    height: 600,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _gartenList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(_gartenList[index].name),
                                          onTap: (){
                                            _idGarten = _gartenList[index].id;
                                            _gartenName = _gartenList[index].name;
                                            setState(() {});
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Text(
                          _gartenName,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(8))),
                          // side: MaterialStateProperty.all(
                          //     BorderSide(color: Colors.black, width: 1)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 0,
                  ),
                ]),
                TableRow(children: [
                  rowTitle('幼儿姓名'),
                  Container(
                    width: 100,
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: buildCommonEdit(
                        context: context,
                        labelText: '请输入幼儿真实姓名',
                        maxLength: 20,
                        maxLines: 1,
                        valueNotifier: _valueNotifier,
                        controller: _idNameCtrl,
                        onChanged: (value) {
                          _idName = value;
                        }),
                  ),
                  Container(
                    height: 0,
                  ),
                ]),
                TableRow(children: [
                  rowTitle('幼儿身份证号'),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: buildCommonEdit(
                        context: context,
                        labelText: '请输入幼儿身份证号',
                        maxLength: 18,
                        maxLines: 1,
                        valueNotifier: _valueNotifier,
                        controller: _idCardCtrl,
                        onChanged: (value) {
                          _idCard = value;
                        }),
                  ),
                  Container(
                    height: 0,
                  ),
                ]),
                TableRow(children: [
                  rowTitle('确认身份证号'),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: buildCommonEdit(
                        context: context,
                        labelText: '请再次输入身份证号',
                        maxLength: 18,
                        maxLines: 1,
                        valueNotifier: _valueNotifier,
                        controller: _reIdCardCtrl,
                        onChanged: (value) {
                          _reIdCard = value;
                        }),
                  ),
                  Container(
                    height: 0,
                  ),
                ]),
                TableRow(children: [
                  rowTitle('民族'),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: SizedBox(
                      height: 58,
                      width: 200,
                      child: OutlinedButton(
                        onPressed: () {

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('请选择民族'),
                                  content: Container(
                                    width: 400,
                                    height: 600,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _nationList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(_nationList[index].name),
                                          onTap: (){
                                            _idNation = _nationList[index].id;
                                            _nationName = _nationList[index].name;
                                            setState(() {});
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Text(
                          _nationName,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(8))),
                          // side: MaterialStateProperty.all(
                          //     BorderSide(color: Colors.black, width: 1)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 0,
                  ),
                ]),
                TableRow(children: [
                  rowTitle('是否当地户口'),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: RadioListTile<int>(
                            title: Text('是'),
                            value: 0,
                            groupValue: _typeLocal,
                            onChanged: (value) {
                              _updateTypeLocal(value);
                            }),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: RadioListTile<int>(
                            title: Text('否'),
                            value: 1,
                            groupValue: _typeLocal,
                            onChanged: (value) {
                              _updateTypeLocal(value);
                            }),
                      )
                    ],
                  ),
                  Container(
                    height: 0,
                  ),
                ]),
                TableRow(children: [
                  rowTitle('是否有接种卡'),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: RadioListTile<int>(
                            title: Text('是'),
                            value: 0,
                            groupValue: _typeJz,
                            onChanged: (value) {
                              _typeJz = value!;
                              setState(() {});
                            }),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: RadioListTile<int>(
                            title: Text('否'),
                            value: 1,
                            groupValue: _typeJz,
                            onChanged: (value) {
                              _typeJz = value!;
                              setState(() {});
                            }),
                      ),
                    ],
                  ),
                  Container(
                    height: 0,
                  ),
                ]),
                TableRow(children: [
                  rowTitle('家长姓名'),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: buildCommonEdit(
                        context: context,
                        labelText: '请输入家长姓名',
                        maxLength: 18,
                        maxLines: 1,
                        valueNotifier: _valueNotifier,
                        controller: _patriarchNameCtrl,
                        onChanged: (value) {
                          _patriarchName = value;
                        }),
                  ),
                  Container(
                    height: 0,
                  ),
                ]),
                TableRow(children: [
                  rowTitle('家长电话'),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: buildCommonEdit(
                        context: context,
                        labelText: '请输入家长联系电话',
                        maxLength: 11,
                        maxLines: 1,
                        valueNotifier: _valueNotifier,
                        controller: _patriarchMobileCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _patriarchMobile = value;
                        }),
                  ),
                  Container(
                    height: 0,
                  ),
                ]),
                TableRow(children: [
                  rowTitle('居住性质'),
                  Row(
                    children: [
                      SizedBox(
                        width: 160,
                        height: 50,
                        child: RadioListTile<String>(
                            title: Text('自有住房'),
                            value: '自有住房',
                            groupValue: _patriarchAddressType,
                            onChanged: (value) {
                              _patriarchAddressType = value!;
                              setState(() {});
                            }),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: RadioListTile<String>(
                            title: Text('租房'),
                            value: '租房',
                            groupValue: _patriarchAddressType,
                            onChanged: (value) {
                              _patriarchAddressType = value!;
                              setState(() {});
                            }),
                      ),
                    ],
                  ),
                  Container(
                    height: 0,
                  ),
                ]),
                TableRow(children: [
                  rowTitle('家庭住址'),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: buildCommonEdit(
                        context: context,
                        labelText: '请输入家庭住址',
                        maxLength: 100,
                        maxLines: 3,
                        valueNotifier: _valueNotifier,
                        controller: _patriarchAddressCtrl,
                        onChanged: (value) {
                          _patriarchAddress = value;
                        }),
                  ),
                  Container(
                    height: 0,
                  ),
                ]),
              ],
            ),
          ),
          Container(
            width: 400,
            height: 60,
            margin: margin(),
            child: ElevatedButton(
              onPressed: () {
                doSignUp();
              },
              child: Text(widget._user == null ? '提交报名信息' : '提交变更信息'),
            ),
          ),
          SizedBox(
            width: 0,
            height: 40,
          )
        ],
      ),
    );
    _secondChild = Container(
      width: 200,
      height: 200,
      decoration: radius(),
      child: Column(
        children: [
          Text('您是第1位报名者'),
          Text('恭喜您,报名成功!'),
          Text('请牢记您的查询码:234289'),
        ],
      ),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: radius(),
        margin: margin(),
        child: AnimatedCrossFade(
            firstChild: _firstChild,
            secondChild: _secondChild,
            crossFadeState: _isSuccess
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(seconds: 1)),
      ),
    );
  }

  doSignUp() {
    if (_gartenName.contains('选择')) {
      debugPrint('请选择幼儿园');
      return;
    }

    if (_idName.toString().trim().isEmpty) {
      debugPrint('请输入幼儿真实姓名');
      return;
    }

    if (_idCard.toString().trim().isEmpty) {
      debugPrint('请再次输入幼儿身份证号');
      return;
    }

    if (_reIdCard.toString().trim().isEmpty) {
      debugPrint('请再次输入身份证号');
      return;
    }

    if (_reIdCard.toString().trim().compareTo(_idCard.toString().trim()) != 0) {
      debugPrint('两次输入的身份证号不一致');
      return;
    }

    if (_nationName.contains('选择')) {
      debugPrint('请选择幼儿民族');
      return;
    }

    if (_patriarchName.toString().trim().isEmpty) {
      debugPrint('请填写幼儿家长姓名');
      return;
    }

    if (_patriarchMobile.toString().trim().isEmpty) {
      debugPrint('请填写幼儿家长电话');
      return;
    }

    if (_patriarchAddress.toString().trim().isEmpty) {
      debugPrint('请输入幼儿家庭住址');
      return;
    }

    if (widget._user == null) {
      KinderUser.add(
              _idName,
              _idCard,
              _idGarten,
              _idNation,
              _typeLocal,
              _typeJz,
              _patriarchName,
              _patriarchMobile,
              _patriarchAddressType,
              _patriarchAddress)
          .then((result) {
        Navigator.of(context).pop();
      }).catchError((error) {});
    } else {
      KinderUser.update(widget._user!.id,
              idName: _idName,
              idCard: _idCard,
              idGarten: _idGarten,
              idNation: _idNation,
              typeLocal: _typeLocal,
              typeJz: _typeJz,
              patriarchName: _patriarchName,
              patriarchMobile: _patriarchMobile,
              patriarchAddressType: _patriarchAddressType,
              patriarchAddress: _patriarchAddress)
          .then((result) {
        Navigator.of(context).pop();
      }).catchError((error) {});
    }
  }

  void _updateTypeLocal(int? value) {
    setState(() {
      _typeLocal = value;
    });
  }
}
