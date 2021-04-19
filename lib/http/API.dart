import 'HTTP.dart';

/// 广告
class Ads extends Object {
  /// 广告列表
  static Future banners({int type = 1}) async {
    var data = new Map<String, dynamic>();
    data['pageOffset'] = 0;
    data['pageLimit'] = 10;
    data['type'] = type;
    data['status'] = 0;
    return HTTP.getInstance().get('/ads/v1/ads', data: data);
  }
}