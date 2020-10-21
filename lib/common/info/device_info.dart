import 'package:flutter/material.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/12
/// @email  a12162266@163.com

class DeviceInfo{
  
  factory DeviceInfo() => _instance;

  DeviceInfo._();
  
  static DeviceInfo _instance;

  static Size _size;
  static double _screenHeight;
  static double _screenWidth;
  static double _statusBarHeight;
  static double _bottomBarHeight;

  static void init(BuildContext context){
    _instance ??= DeviceInfo._();
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    _size = mediaQuery.size;
    _screenHeight = mediaQuery.size.height;
    _screenWidth = mediaQuery.size.width;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
  }

  ///size
  static Size get size => _size;
  ///当前设备高度 dp
  static double get screenHeight => _screenHeight;
  /// 当前设备宽度 dp
  static double get screenWidth => _screenWidth;
  /// 状态栏高度 dp 刘海屏会更高
  static double get statusBarHeight => _statusBarHeight;
  /// 底部安全区距离 dp
  static double get bottomBarHeight => _bottomBarHeight;
}