import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/global/Helper.dart';
import 'package:flutter_web/http/API.dart';
import 'package:flutter_web/model/UserList.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StatisticsDetailPage extends StatefulWidget {
  static const String routeName = '/web/statistics-detail';

  final String title;

  StatisticsDetailPage(this.title);

  static Future show(BuildContext context, String title) {
    return Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => StatisticsDetailPage(title)));
  }

  @override
  _StatisticsDetailPageState createState() => _StatisticsDetailPageState();
}

class _StatisticsDetailPageState extends State<StatisticsDetailPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  var _userList = <UserItem>[];

  void _onRefresh() async {
    _loadData(true);
  }

  void _onLoading() async {
    _loadData(false);
  }

  void _loadData(bool isRefresh) async {
    if (isRefresh) {
      _userList.clear();
    } else {
      if (_userList.length <= pageSize) {
        _refreshController.loadNoData();
        return;
      }
    }
    _success(result) {
      var list = result as List;
      List<UserItem> newList = list.map((i) => UserItem.fromJson(i)).toList();
      if (isRefresh) {
        _userList.clear();
        _userList.addAll(newList);
        setState(() {});
        _refreshController.refreshCompleted();
        if (newList.isEmpty) {
          if (newList.length <= pageSize) {
            _refreshController.loadNoData();
          }
        }
      } else {
        _userList.addAll(newList);
        setState(() {});
        _refreshController.loadComplete();
        if (newList.isNotEmpty) {
          if (newList.length <= pageSize) {
            _refreshController.loadNoData();
          }
        } else {
          _refreshController.loadNoData();
        }
      }
    }

    _failure(error) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));
      setState(() {});
      if (isRefresh) {
        _refreshController.refreshCompleted();
        _refreshController.refreshFailed();
      } else {
        _refreshController.loadComplete();
        _refreshController.loadFailed();
      }
    }

    KinderUser.list(_userList.length).then(_success).catchError(_failure);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: radius(),
          margin: margin(),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
              itemBuilder: (c, i) {
                if (i == 0) {
                  return rowUserTitle('序号', '幼儿姓名', '性别', '身份证号码', '民族');
                }

                return rowContent(i, _userList[i - 1]);
              },
              itemCount: _userList.length + 1,
            ),
          ),
        ),
      ),
    );
  }
}
