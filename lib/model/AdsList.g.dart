// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdsList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdsList _$AdsListFromJson(Map<String, dynamic> json) {
  return AdsList(
    adsList: (json['adsList'] as List)
        .map((e) => AdsItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AdsListToJson(AdsList instance) => <String, dynamic>{
      'adsList': instance.adsList,
    };

AdsItem _$AdsItemFromJson(Map<String, dynamic> json) {
  return AdsItem(
    json['id'] as String,
    json['title'] as String,
    json['content'] as String,
    json['cover'] as String,
    json['url'] as String,
    json['publishTime'] as int,
    json['deadlineTime'] as int,
    json['type'] as int,
    json['status'] as int,
    json['urlType'] as int,
    json['weight'] as int,
  );
}

Map<String, dynamic> _$AdsItemToJson(AdsItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'cover': instance.cover,
      'url': instance.url,
      'publishTime': instance.publishTime,
      'deadlineTime': instance.deadlineTime,
      'type': instance.type,
      'status': instance.status,
      'urlType': instance.urlType,
      'weight': instance.weight,
    };
