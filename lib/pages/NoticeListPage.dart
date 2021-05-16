import 'package:flutter/material.dart';
import 'package:flutter_web/global/Helper.dart';
import 'package:flutter_web/http/API.dart';
import 'package:flutter_web/model/NoticeList.dart';
import 'package:flutter_web/model/UserList.dart';
import 'package:flutter_web/pages/NoticeDetailPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NoticeListPage extends StatefulWidget {
  static const String routeName = '/web/notice-list';

  NoticeListPage(this.title);

  final String title;

  @override
  _NoticeListPageState createState() => _NoticeListPageState();
}

class _NoticeListPageState extends State<NoticeListPage> {

  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  var _noticeList = <NoticeItem>[];

  void _onRefresh() async {
    _loadData(true);
  }

  void _onLoading() async {
    _loadData(false);
  }

  void _loadData(bool isRefresh) async {
    if (isRefresh) {
      _noticeList.clear();
    } else {
      if (_noticeList.length <= pageSize) {
        _refreshController.loadNoData();
        return;
      }
    }
    _success(result) {
      var list = result as List;
      List<NoticeItem> newList = list.map((i) => NoticeItem.fromJson(i)).toList();
      if (isRefresh) {
        _noticeList.clear();
        _noticeList.addAll(newList);
        setState(() {});
        _refreshController.refreshCompleted();
        if (newList.isEmpty) {
          if (newList.length <= pageSize) {
            _refreshController.loadNoData();
          }
        }
      } else {
        _noticeList.addAll(newList);
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

    KinderNotice.list(_noticeList.length).then(_success).catchError(_failure);
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
                return noticeItem(_noticeList[i],(){
                  NoticeDetailPage.show(context, _noticeList[i]);
                });
              },
              itemCount: _noticeList.length,
            ),
          ),
        ),
      ),
    );
  }
}
