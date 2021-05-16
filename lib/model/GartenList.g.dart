// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GartenList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GartenList _$GartenListFromJson(Map<String, dynamic> json) {
  return GartenList(
    gartenList: (json['gartenList'] as List<dynamic>)
        .map((e) => GartenItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GartenListToJson(GartenList instance) =>
    <String, dynamic>{
      'gartenList': instance.gartenList,
    };

GartenItem _$GartenItemFromJson(Map<String, dynamic> json) {
  return GartenItem(
    json['id'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$GartenItemToJson(GartenItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
