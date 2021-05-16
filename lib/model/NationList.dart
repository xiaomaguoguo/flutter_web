import 'package:json_annotation/json_annotation.dart';

part 'NationList.g.dart';

@JsonSerializable()
class NationList {
  List<NationItem> nationList;

  NationList({required List<NationItem> nationList}) : nationList = nationList;

  factory NationList.fromJson(Map<String, dynamic> json) =>
      _$NationListFromJson(json);

  Map<String, dynamic> toJson() => _$NationListToJson(this);
}

@JsonSerializable()
class NationItem {
  final String id;
  final String name;

  NationItem(
      this.id,
      this.name);

  //不同的类使用不同的mixin即可
  factory NationItem.fromJson(Map<String, dynamic> json) =>
      _$NationItemFromJson(json);
  Map<String, dynamic> toJson() => _$NationItemToJson(this);
}
