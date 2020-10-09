import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zuiyou_flutter/common/info/app_info.dart';
import 'package:zuiyou_flutter/common/routers/router_util.dart';
import 'package:zuiyou_flutter/common/routers/routers.dart';
import 'package:zuiyou_flutter/common/utils/image_utils.dart';
import 'package:zuiyou_flutter/common/utils/theme_utils.dart';
import 'package:zuiyou_flutter/widget/load_image.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/21
/// @email  a12162266@163.com

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  int _status = 0;
  final List<String> _guideList = <String>['app_start_1', 'app_start_2', 'app_start_3'];
  //流订阅
  StreamSubscription<int> _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //sp的初始化
      await SpUtil.getInstance();
      if(SpUtil.getBool(AppInfo.keyGuide, defValue: true)){
        for(final String image in _guideList) {
          //将图片预存到图片缓存中
          precacheImage(ImageUtils.getAssetImage(image, format: ImageFormat.webp), context);
        }
      }
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
  
  void _initSplash() {
    _subscription = Stream<int>.value(1).delay(const Duration(milliseconds: 1000)).listen((_) {
      if (SpUtil.getBool(AppInfo.keyGuide, defValue: true)) {
        SpUtil.putBool(AppInfo.keyGuide, false);
        _initGuide();
      } else {
        _goHome();
      }
    });
  }
  
  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }
  
  void _goHome() {
    RouterUtil.push(context, Routers.home, replace: true);
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: ThemeUtils.getBackgroundColor(context),
      child: _status == 0 ?
      Column(
        children:  const <Widget>[
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 50, right: 50, bottom: 100),
                child: LoadAssetImage('splash_center',),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20,),
            child: LoadAssetImage(
              'splash_icon',
              height: 50,
              width: 100,
            ),
          ),
        ],
      ) :
      Swiper(
        key: const Key('swiper'),
        itemCount: _guideList.length,
        loop: false,
        itemBuilder: (_, int index){
          return LoadAssetImage(
            _guideList[index],
            key: Key(_guideList[index]),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            format: ImageFormat.webp,
          );
        },
        onTap: (int index) {
          if(index == _guideList.length - 1){
            _goHome();
          }
        },
      ),
    );
  }
}