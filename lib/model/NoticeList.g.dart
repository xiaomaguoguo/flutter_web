// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NoticeList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeList _$NoticeListFromJson(Map<String, dynamic> json) {
  return NoticeList(
    noticeList: (json['noticeList'] as List<dynamic>)
        .map((e) => NoticeItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NoticeListToJson(NoticeList instance) =>
    <String, dynamic>{
      'noticeList': instance.noticeList,
    };

NoticeItem _$NoticeItemFromJson(Map<String, dynamic> json) {
  return NoticeItem(
    json['title'] as String,
    json['content'] as String,
    json['createTime'] as int,
    json['updateTime'] as int,
  );
}

Map<String, dynamic> _$NoticeItemToJson(NoticeItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
    };
