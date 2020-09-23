import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/common/routers/web_page_transitions.dart';

import '../res/app_color.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/21
/// @email  a12162266@163.com

extension ThemeModelExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  final String appTheme = 'AppTheme';
  void syncTheme(){
    final String theme = SpUtil.getString(appTheme);
    if(theme.isNotEmpty && theme != ThemeMode.system.value) {
      notifyListeners();
    }
  }
  
  void setTheme(ThemeMode themeMode) {
    SpUtil.putString(appTheme, themeMode.value);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    final String theme = SpUtil.getString(appTheme);
    switch(theme){
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
  
  ThemeData getTheme({bool isDarkMode = false}) {
    if(isDarkMode){
      return ThemeData(
        errorColor: AppColor.dark_red,
        brightness: Brightness.dark,
        //主题色
        primaryColor: AppColor.dark_app_main,
        accentColor: AppColor.dark_app_main,
        // Tab指示器颜色
        indicatorColor: AppColor.dark_app_main,
        // 页面背景色
        scaffoldBackgroundColor: AppColor.dark_bg_color,
        // 主要用于Material背景色
        canvasColor: AppColor.dark_material_bg,
        // 文字选择色（输入框复制粘贴菜单）
        textSelectionColor: AppColor.app_main.withAlpha(70),
        textSelectionHandleColor: AppColor.app_main,
        textTheme: const TextTheme(
          // TextField输入文字颜色
          subtitle1: TextStyle(fontSize: 14.0, color: AppColor.dark_text, textBaseline: TextBaseline.alphabetic),
          // Text文字样式
          bodyText2: TextStyle(fontSize: 14.0, color: AppColor.dark_text, textBaseline: TextBaseline.alphabetic),
          subtitle2: TextStyle(fontSize: 12.0, color: AppColor.dark_text_gray, fontWeight: FontWeight.normal),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(fontSize: 14.0, color: AppColor.dark_unselected_item_color),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          color: AppColor.dark_bg_color,
          brightness: Brightness.dark,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColor.dark_line,
          space: 0.6,
          thickness: 0.6,
        ),
        cupertinoOverrideTheme: const CupertinoThemeData(
          brightness: Brightness.dark
        ),
        pageTransitionsTheme: NoTransitionsOnWeb(),
      );
    } else {
      return ThemeData(
        errorColor: AppColor.red,
        brightness: Brightness.light,
        //主题色
        primaryColor: AppColor.app_main,
        accentColor: AppColor.app_main,
        // Tab指示器颜色
        indicatorColor: AppColor.app_main,
        // 页面背景色
        scaffoldBackgroundColor: AppColor.bg_color,
        // 主要用于Material背景色
        canvasColor: AppColor.material_bg,
        // 文字选择色（输入框复制粘贴菜单）
        textSelectionColor: AppColor.app_main.withAlpha(70),
        textSelectionHandleColor: AppColor.app_main,
        textTheme: const TextTheme(
          // TextField输入文字颜色
          subtitle1: TextStyle(fontSize: 14.0, color: AppColor.text, textBaseline: TextBaseline.alphabetic),
          // Text文字样式
          bodyText2: TextStyle(fontSize: 14.0, color: AppColor.text, textBaseline: TextBaseline.alphabetic),
          subtitle2: TextStyle(fontSize: 12.0, color: AppColor.text_gray, fontWeight: FontWeight.normal),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(fontSize: 14.0, color: AppColor.unselected_item_color),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          color: AppColor.bg_color,
          brightness: Brightness.light,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColor.line,
          space: 0.6,
          thickness: 0.6,
        ),
        cupertinoOverrideTheme: const CupertinoThemeData(
            brightness: Brightness.light
        ),
        pageTransitionsTheme: NoTransitionsOnWeb(),
      );
    }
  }
}