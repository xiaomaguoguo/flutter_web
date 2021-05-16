import 'package:json_annotation/json_annotation.dart';

part 'GartenList.g.dart';

@JsonSerializable()
class GartenList {
  List<GartenItem> gartenList;

  GartenList({required List<GartenItem> gartenList}) : gartenList = gartenList;

  factory GartenList.fromJson(Map<String, dynamic> json) =>
      _$GartenListFromJson(json);

  Map<String, dynamic> toJson() => _$GartenListToJson(this);
}

@JsonSerializable()
class GartenItem {
  final String id;
  final String name;

  GartenItem(
      this.id,
      this.name);

  //不同的类使用不同的mixin即可
  factory GartenItem.fromJson(Map<String, dynamic> json) =>
      _$GartenItemFromJson(json);
  Map<String, dynamic> toJson() => _$GartenItemToJson(this);
}
