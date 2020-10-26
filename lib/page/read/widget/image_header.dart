import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:zuiyou_flutter/widget/load_image.dart';

/// @description 
/// @Created by huang
/// @Date   2020/10/21
/// @email  a12162266@163.com

class ImageHeader extends Header{
  ImageHeader({this.displacement, Duration completeDuration = const Duration(seconds: 1), bool enableHapticFeedback = false,}): super(
    float: false,
    extent: 80.0,
    triggerDistance: 80.0,
    completeDuration: completeDuration == null
        ? Duration(milliseconds: 1000,)
        : completeDuration + Duration(milliseconds: 1000,),
    enableInfiniteRefresh: false,
    enableHapticFeedback: enableHapticFeedback,
  );
  
  final double displacement;
  final LinkHeaderNotifier linkNotifier = LinkHeaderNotifier();
  
  @override
  Widget contentBuilder(
      BuildContext context, //上下文
      RefreshMode refreshState, //刷新状态
      double pulledExtent, //拉动距离
      double refreshTriggerPullDistance, //触发刷新距离
      double refreshIndicatorExtent, //header高度
      AxisDirection axisDirection, // 列表方向
      bool float, //是否浮动
      Duration completeDuration, //完成延迟
      bool enableInfiniteRefresh, //是否开启无限刷新
      bool success, //刷新是否成功
      bool noMore, //是否没有更多
      ) {
    linkNotifier.contentBuilder(context, refreshState, pulledExtent,
        refreshTriggerPullDistance, refreshIndicatorExtent, axisDirection,
        float, completeDuration, enableInfiniteRefresh, success, noMore);
    return ImageHeaderWidget(linkNotifier: linkNotifier,);
  }
}

class ImageHeaderWidget extends StatefulWidget {
  const ImageHeaderWidget({Key key, this.displacement, this.linkNotifier}) : super(key: key);

  final double displacement;
  final LinkHeaderNotifier linkNotifier;

  @override
  ImageHeaderWidgetState createState() => ImageHeaderWidgetState();
}

class ImageHeaderWidgetState extends State<ImageHeaderWidget> with TickerProviderStateMixin{
  Animation<double> logoAnimation;
  AnimationController logoController;
  Animation<double> animation;
  AnimationController controller;

  RefreshMode get _refreshState => widget.linkNotifier.refreshState;
  double get _pulledExtent => widget.linkNotifier.pulledExtent;
  double get _riggerPullDistance => widget.linkNotifier.refreshTriggerPullDistance;
  bool _startAn = false;
  
  @override
  void initState() {
    super.initState();
    logoController =  AnimationController(duration: const Duration(milliseconds: 350), vsync: this);
    logoAnimation = Tween(begin: 10.0, end: 0.0).animate(logoController);
    controller = AnimationController(duration: const Duration(milliseconds: 350), vsync: this);
    animation = Tween(begin: 24.0, end: 14.0).animate(controller);
  }
  void _listtener(){
    setState(()=>{});
  }
  void _statusListener1(AnimationStatus status){
    if (status == AnimationStatus.completed) {
      // 动画完成后反转
      controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      // 反转回初始状态时继续播放，实现无限循环
      controller.forward();
    }
  }
  void _statusListener2(AnimationStatus status){
    if (status == AnimationStatus.completed) {
      // 动画完成后反转
      logoController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      // 反转回初始状态时继续播放，实现无限循环
      logoController.forward();
    }
  }
  
  @override
  void dispose() {
    logoController.dispose();
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // print('$_refreshState + $_pulledExtent');
    if(!_startAn){
      if(_refreshState == RefreshMode. armed || _refreshState == RefreshMode.refresh || _pulledExtent > _riggerPullDistance){
        print('开始动画');
        //启动动画(正向执行)
        logoController.addListener(_listtener);
        animation.addStatusListener(_statusListener1);
        logoAnimation.addStatusListener(_statusListener2);
        logoController.forward();
        controller.forward();
        _startAn = true;
      }
    } else {
      if(_refreshState == RefreshMode.inactive && _pulledExtent == 0.0){
        print('移除动画');
        logoController.removeListener(_listtener);
        animation.removeStatusListener(_statusListener1);
        logoAnimation.removeStatusListener(_statusListener2);
        _startAn = false;
      }
    }
    return Stack(
      children: [
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: logoAnimation.value),
                child: const LoadAssetImage(
                  'zuiyou_logo',
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ClipOval(
                  child: Container(
                    height: 5,
                    width: animation.value,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}