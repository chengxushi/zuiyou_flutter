import 'package:extended_image/extended_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/21
/// @email  a12162266@163.com

class ImageUtils {
  
  static ImageProvider getAssetImage(String image, {ImageFormat format = ImageFormat.png}) {
    return AssetImage(getImgPath(image, format: format));
  }
  
  static String getImgPath(String name, {ImageFormat format = ImageFormat.png}) {
    return 'assets/images/$name.${format.value}';
  }
  
  static ImageProvider getImageProvider(String imageUrl, {String holderImg = 'none'}){
    if(TextUtil.isEmpty(imageUrl)) {
      return getAssetImage(getImgPath(holderImg));
    } else {
      return ExtendedNetworkImageProvider(
        imageUrl,
        cache: true,
        scale: 1.0, //比例
        retries: 3, //请求尝试次数
        timeRetry: const Duration(milliseconds: 100), //请求重试间隔
      );
    }
  }
}

enum ImageFormat {
  png,
  jpg,
  gif,
  webp
}

extension ImageFormatExtension on ImageFormat {
  String get value => <String>['png', 'jpg', 'gif', 'webp'][index];
}