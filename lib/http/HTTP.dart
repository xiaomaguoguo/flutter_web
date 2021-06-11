import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'CloudException.dart';

class HTTP {
  static var localURL = 'http://localhost:8080';

  static var defaultBaseURL = '$localURL/api';
  static var webURL = '$onlineURL/web';

  static HTTP _instance = HTTP._internal();

  Dio _dio = new Dio(new BaseOptions(
    baseUrl: defaultBaseURL,
    connectTimeout: 15000,
    sendTimeout: 10000,
    receiveTimeout: 5000,
    headers: {},
  ));

  factory HTTP() => _instance;

  HTTP._internal() {
    // if (_dio == null) {
    //   _dio = new Dio(new BaseOptions(
    //     baseUrl: defaultBaseURL,
    //     connectTimeout: 15000,
    //     sendTimeout: 10000,
    //     receiveTimeout: 5000,
    //     headers: {},
    //   ));
    // }
  }

  static HTTP getInstance({String? baseUrl}) {
    _instance._dio.options.baseUrl = baseUrl ?? defaultBaseURL;
    return _instance;
  }

  get(url, {Map<String, dynamic>? data, options, cancelToken}) async {
    return Future(() async {
      debugPrint('get 请求启动! url：$url ,body: $data');
      Response response;

      try {
        response = await _dio.get(
          url,
          queryParameters: data,
          cancelToken: cancelToken,
        );
        int code = response.data['code'];
        String msg = response.data['message'];
        if (code == 0) {
          debugPrint('get 请求成功!response.data：${response.data['data']}');
          return response.data['data'];
        } else {
          debugPrint('get 请求失败!response.data：${response.data}');
          throw Exception(msg);
        }
      } on DioError catch (e) {
        if (CancelToken.isCancel(e)) {
          debugPrint('get 请求取消! ' + e.message);
          throw e;
        }
        String msg = e.response!.data['message'];
        int code = e.response!.data['code'];
        debugPrint('get 请求发生错误code = $code ; msg = $msg');
        throw CloudException(code, msg);
      }
    });
  }

  Future post(
      {isPut = false, url, Map<String, dynamic>? data, options, cancelToken}) {
    // ignore: missing_return
    return new Future(() async {
      debugPrint(
          '${DateTime.now()} ${isPut ? 'put' : 'post'}请求启动! url：$url, body: $data');
      Response response;

      try {
        if (isPut) {
          //更新操作
          response = await _dio.put(
            url,
            data: jsonEncode(data),
            cancelToken: cancelToken,
          );
        } else {
          response = await _dio.post(
            url,
            data: jsonEncode(data),
            cancelToken: cancelToken,
          );
        }

//        var baseModel = BaseModel.fromJson(response.data);
        int code = response.data['code'];
        String msg = response.data['message'];
        if (code == 0) {
          if (response.data['data'] is List) {
            List data = response.data['data'];
            return data;
          } else if (response.data['data'] is Map) {
            Map<String, dynamic> data = response.data['data'];
            return data;
          }
          return response.data['data'];
          debugPrint('post 请求成功!response.data：${response.data['data']}');
        } else {
          debugPrint(
              '${DateTime.now()} post 请求失败! url：$url, response.data：${response.data}');
          throw CloudException(code, msg);
        }
      } on DioError catch (e) {
        if (CancelToken.isCancel(e)) {
          debugPrint('${DateTime.now()} post 请求取消! url：$url,  ' + e.message);
          throw CloudException(-1, e.message);
        }
        String msg = e.response!.data['message'];
        int code = e.response!.data['code'];
        debugPrint('post 请求发生错误code = $code ; msg = $msg');
        throw CloudException(code, msg);
      }
    });
  }
}
