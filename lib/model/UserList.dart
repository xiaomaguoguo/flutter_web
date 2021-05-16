import 'package:json_annotation/json_annotation.dart';

part 'UserList.g.dart';

@JsonSerializable()
class UserList {
  List<UserItem> userList;

  UserList({required List<UserItem> userList}) : userList = userList;

  factory UserList.fromJson(Map<String, dynamic> json) =>
      _$UserListFromJson(json);

  Map<String, dynamic> toJson() => _$UserListToJson(this);
}

@JsonSerializable()
class UserItem {
  final String id;
  final String idCard;
  final String idName;
  final String idGarten;
  final String idNation;
  final String nationName;
  final String patriarchName;
  final String patriarchMobile;
  final String patriarchAddress;
  final String patriarchAddressType;
  final int typeJz;
  final int typeLocal;

  UserItem(
      this.id,
      this.idCard,
      this.idName,
      this.idGarten,
      this.idNation,
      this.nationName,
      this.patriarchName,
      this.patriarchMobile,
      this.patriarchAddress,
      this.patriarchAddressType,
      this.typeJz,
      this.typeLocal);

  //不同的类使用不同的mixin即可
  factory UserItem.fromJson(Map<String, dynamic> json) =>
      _$UserItemFromJson(json);
  Map<String, dynamic> toJson() => _$UserItemToJson(this);
}
