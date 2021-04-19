import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'CloudException.dart';

class HTTP {
  static var onlineURL = 'https://kannima.com';

  static var defaultBaseURL = '$onlineURL/api';
  static var webURL = '$onlineURL/web';

  static HTTP _instance = HTTP._internal();

  Dio _dio;

  factory HTTP() => _instance;

  HTTP._internal() {
    if (_dio == null) {
      _dio = new Dio(new BaseOptions(
        baseUrl: defaultBaseURL,
        connectTimeout: 15000,
        sendTimeout: 10000,
        receiveTimeout: 5000,
        headers: {},
      ));
    }
  }

  static HTTP getInstance({String baseUrl}) {
    if (_instance._dio != null) {
      _instance._dio.options.baseUrl = baseUrl ?? defaultBaseURL;
    }
    return _instance;
  }

  get(url, {Map<String, dynamic> data, options, cancelToken}) async {
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
        String msg = e.response.data['message'];
        int code = e.response.data['code'];
        debugPrint('get 请求发生错误code = $code ; msg = $msg');
        throw CloudException(code, msg);
      }
    });
  }
}
