// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserList _$UserListFromJson(Map<String, dynamic> json) {
  return UserList(
    userList: (json['userList'] as List<dynamic>)
        .map((e) => UserItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserListToJson(UserList instance) => <String, dynamic>{
      'userList': instance.userList,
    };

UserItem _$UserItemFromJson(Map<String, dynamic> json) {
  return UserItem(
    json['id'] as String,
    json['idCard'] as String,
    json['idName'] as String,
    json['idGarten'] as String,
    json['idNation'] as String,
    json['nationName'] as String,
    json['patriarchName'] as String,
    json['patriarchMobile'] as String,
    json['patriarchAddress'] as String,
    json['patriarchAddressType'] as String,
    json['typeJz'] as int,
    json['typeLocal'] as int,
  );
}

Map<String, dynamic> _$UserItemToJson(UserItem instance) => <String, dynamic>{
      'id': instance.id,
      'idCard': instance.idCard,
      'idName': instance.idName,
      'idGarten': instance.idGarten,
      'idNation': instance.idNation,
      'nationName': instance.nationName,
      'patriarchName': instance.patriarchName,
      'patriarchMobile': instance.patriarchMobile,
      'patriarchAddress': instance.patriarchAddress,
      'patriarchAddressType': instance.patriarchAddressType,
      'typeJz': instance.typeJz,
      'typeLocal': instance.typeLocal,
    };
