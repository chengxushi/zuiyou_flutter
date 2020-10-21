import 'package:flutter/material.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:zuiyou_flutter/widget/load_image.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/20
/// @email  a12162266@163.com

class MyRefreshHeader extends StatelessWidget {
  const MyRefreshHeader(this.info, this.maxDragOffset);
  final PullToRefreshScrollNotificationInfo info;
  final double maxDragOffset;
  
  @override
  Widget build(BuildContext context) {
    if(info == null){
      print('info is null');
      return const SizedBox();
    }
    final double dragOffset = info?.dragOffset ?? 0.0;
    return Container(
      height: dragOffset,
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          if (info.mode == RefreshIndicatorMode.armed || info.mode == RefreshIndicatorMode.snap || info.mode == RefreshIndicatorMode.refresh)
            RefreshImage()
          else
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: LoadAssetImage(
                      'zuiyou_logo',
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ClipOval(
                      child: Container(
                        height: 5,
                        width: 24,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class RefreshImage extends StatefulWidget {
  @override
  RefreshImageState createState() => RefreshImageState();
}

class RefreshImageState extends State<RefreshImage> with TickerProviderStateMixin{
  
  Animation<double> logoAnimation;
  AnimationController logoController;
  Animation<double> animation;
  AnimationController controller;
  
  @override
  void initState() {
    super.initState();
    logoController =  AnimationController(duration: const Duration(milliseconds: 350), vsync: this);
    logoAnimation = Tween(begin: 10.0, end: 0.0).animate(logoController)
      ..addListener(() {
        setState(()=>{});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画完成后反转
          logoController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // 反转回初始状态时继续播放，实现无限循环
          logoController.forward();
        }
      });
    controller = AnimationController(duration: const Duration(milliseconds: 350), vsync: this);
    animation = Tween(begin: 24.0, end: 14.0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画完成后反转
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // 反转回初始状态时继续播放，实现无限循环
          controller.forward();
        }
      });
    //启动动画(正向执行)
    logoController.forward();
    controller.forward();
  }

  @override
  void dispose() {
    logoController.dispose();
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}