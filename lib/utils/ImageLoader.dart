import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget loadImage(
    {required String imageUrl,
    Widget? placeholder,
    BoxFit fit = BoxFit.fill,
    double width = double.infinity,
    double height = double.infinity,
    bool isIconHolder = true}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit,
    fadeInDuration: const Duration(milliseconds: 1000),
    width: width,
    height: height,
    placeholder: (context, url) =>
        placeholder ??
        Center(
          child: isIconHolder ? Icon(Icons.cloud_queue) : indicator,
        ),
    errorWidget: (context, url, error) => new Icon(Icons.error),
  );
}

const indicator = SizedBox(
  child: CircularProgressIndicator(
    strokeWidth: 2.0,
    valueColor: const AlwaysStoppedAnimation<Color>(Colors.brown),
  ),
  width: 14.0,
  height: 14.0,
);

/// oss缩略图
String buildThumbnail(url, {int width = 100, int height = 100}) {
  return '$url?x-oss-process=image/resize,m_fill,h_$height,w_$width';
}
