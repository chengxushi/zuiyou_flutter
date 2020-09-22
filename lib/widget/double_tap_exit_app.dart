import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// @description 双击返回退出应用
/// @Created by huang
/// @Date   2020/9/21
/// @email  a12162266@163.com

class DoubleTapExitApp extends StatefulWidget {
  
  const DoubleTapExitApp({Key key, this.duration = const Duration(milliseconds: 2500), this.child}) : super(key: key);

  final Widget child;
  final Duration duration;

  @override
  _DoubleTapExitAppState createState() => _DoubleTapExitAppState();
}

class _DoubleTapExitAppState extends State<DoubleTapExitApp> {
  DateTime  _lastTime;
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }
  
  Future<bool> _isExit() async {
    if (_lastTime == null || DateTime.now().difference(_lastTime) > widget.duration) {
      _lastTime = DateTime.now();
      BotToast.showText(text: '再次点击退出应用');
      return Future<bool>.value(false);
    }
    /// 不推荐使用 `dart:io` 的 exit(0)
    await SystemNavigator.pop();
    return Future<bool>.value(true);
  }
}