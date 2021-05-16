// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NationList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NationList _$NationListFromJson(Map<String, dynamic> json) {
  return NationList(
    nationList: (json['nationList'] as List<dynamic>)
        .map((e) => NationItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$NationListToJson(NationList instance) =>
    <String, dynamic>{
      'nationList': instance.nationList,
    };

NationItem _$NationItemFromJson(Map<String, dynamic> json) {
  return NationItem(
    json['id'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$NationItemToJson(NationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
