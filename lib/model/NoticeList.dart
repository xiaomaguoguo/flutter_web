import 'package:json_annotation/json_annotation.dart';

part 'NoticeList.g.dart';

@JsonSerializable()
class NoticeList {
  List<NoticeItem> noticeList;

  NoticeList({required List<NoticeItem> noticeList}) : noticeList = noticeList;

  factory NoticeList.fromJson(Map<String, dynamic> json) =>
      _$NoticeListFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeListToJson(this);
}

@JsonSerializable()
class NoticeItem {

  final String title;
  final String content;
  final int createTime;
  final int updateTime;

  NoticeItem(
      this.title,
      this.content,
      this.createTime,
      this.updateTime);

  //不同的类使用不同的mixin即可
  factory NoticeItem.fromJson(Map<String, dynamic> json) =>
      _$NoticeItemFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeItemToJson(this);
}
