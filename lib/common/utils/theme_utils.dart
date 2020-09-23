import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/res/app_color.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/22
/// @email  a12162266@163.com

class ThemeUtils {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
  
  static Color getDarkColor(BuildContext context, Color darkColor) {
    return isDark(context) ? darkColor : null;
  }
  
  static Color getIconColor(BuildContext context) {
    return isDark(context) ? AppColor.dark_text : null;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Color getDialogBackgroundColor(BuildContext context) {
    return Theme.of(context).canvasColor;
  }
}