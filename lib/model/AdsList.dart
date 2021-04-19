import 'package:json_annotation/json_annotation.dart';

part 'AdsList.g.dart';

@JsonSerializable()
class AdsList {
  @JsonKey(nullable: false)
  List<AdsItem> adsList;

  AdsList({List<AdsItem> adsList}) : adsList = adsList ?? <AdsItem>[];

  factory AdsList.fromJson(Map<String, dynamic> json) =>
      _$AdsListFromJson(json);

  Map<String, dynamic> toJson() => _$AdsListToJson(this);
}

@JsonSerializable()
class AdsItem {
  final String id;
  final String title;
  final String content;
  final String cover;
  final String url;
  final int publishTime;
  final int deadlineTime;

  final int type;
  final int status;
  final int urlType;
  final int weight;
  AdsItem(
      this.id,
      this.title,
      this.content,
      this.cover,
      this.url,
      this.publishTime,
      this.deadlineTime,
      this.type,
      this.status,
      this.urlType,
      this.weight);

  //不同的类使用不同的mixin即可
  factory AdsItem.fromJson(Map<String, dynamic> json) =>
      _$AdsItemFromJson(json);
  Map<String, dynamic> toJson() => _$AdsItemToJson(this);
}
