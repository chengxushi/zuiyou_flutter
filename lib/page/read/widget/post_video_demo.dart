
import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/common/info/device_info.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/22
/// @email  a12162266@163.com

class PostVideoDemo extends StatefulWidget {
  @override
  PostVideoDemoState createState() => PostVideoDemoState();
}

class PostVideoDemoState extends State<PostVideoDemo> {
  
  @override
  Widget build(BuildContext context) {
    String heroTag = 'https://pic1.zhimg.com/80/v2-a1c75773a3222f2241c15aab76d5bd54_720w.jpg?source=1940ef5c';
    // String heroTag = 'https://avatars0.githubusercontent.com/u/50852805?s=400&u=9a79291231aaa02762dde3c9b9edc64b4fbb1017&v=4';
    String heroTag2 = 'https://avatars0.githubusercontent.com/u/50852805?s=400&u=9a79291231aaa02762dde3c9b9edc64b4fbb1017&v=4';
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          children: [
            Container(
              // width: 100,
              // height: 100,
              margin: EdgeInsets.only(top: 100, left: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: GestureDetector(
                  onTap: () {
                    //上下滑动路由效果
                    // Navigator.push(context, SimpleRoute(builder: (context) => VideoPlay(tag: heroTag,)));
                    //缩放路由效果
                    // Navigator.push(context, ScaleRoute(page: VideoPlay(tag: heroTag,)));
            
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlay(tag: heroTag,)));
            
                    //仅透明路由
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) => VideoPlay(heroTag: heroTag,),
                      ),
                    );
                  },
                  child: Hero(
                    tag: heroTag,
                    child: Image.network(heroTag, width: 100, height: 100, fit: BoxFit.cover,),
                  ),
                ),
              ),
            ),
            Container(
              // width: 100,
              // height: 100,
              margin: const EdgeInsets.only(top: 400, right: 100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: GestureDetector(
                  onTap: () {
                    //上下滑动路由效果
                    // Navigator.push(context, SimpleRoute(builder: (context) => VideoPlay(tag: heroTag,)));
                    //缩放路由效果
                    // Navigator.push(context, ScaleRoute(page: VideoPlay(tag: heroTag,)));
            
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlay(tag: heroTag,)));
            
                    //仅透明路由
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) => VideoPlay(heroTag: heroTag2,),
                      ),
                    );
                  },
                  child: Hero(
                    tag: heroTag2,
                    child: Image.network(heroTag2, width: 100, height: 100, fit: BoxFit.cover,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//第二个页面
class VideoPlay extends StatelessWidget {
  final String heroTag;

  const VideoPlay({Key key, this.heroTag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: double.infinity,
          child: Hero(
            tag: heroTag,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: ExtendedImage.network(
                heroTag,
                mode: ExtendedImageMode.gesture,
                enableSlideOutPage: true,
                initGestureConfigHandler: (ExtendedImageState state){
                  //大图自适应放大
                  double initialScale = 1.0;
                  if (state.extendedImageInfo != null && state.extendedImageInfo.image != null && DeviceInfo.size != null){
                    initialScale = initScale(
                      Size(
                        state.extendedImageInfo.image.width.toDouble(),
                        state.extendedImageInfo.image.height.toDouble(),
                      ),
                    );
                  }
                  return GestureConfig(
                    initialScale: initialScale,
                    maxScale: max(initialScale, 5.0),
                    minScale: initialScale,
                    animationMaxScale: max(initialScale, 5.0),
                    initialAlignment: InitialAlignment.topCenter,
                    cacheGesture: false,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  double initScale(Size imageSize) {
    //屏幕尺寸
    final Size size = DeviceInfo.size;
    //图片比例
    final double n1 = imageSize.height / imageSize.width;
    //屏幕比例
    final double n2 = size.height / size.width;
    if (n1 > n2) {
      final FittedSizes fittedSizes = applyBoxFit(BoxFit.contain, imageSize, size);
      final Size destinationSize = fittedSizes.destination;
      // print(destinationSize);
      return size.width / destinationSize.width;
    } else if (n1 / n2 < 1 / 4) {
      final FittedSizes fittedSizes = applyBoxFit(BoxFit.contain, imageSize, size);
      final Size destinationSize = fittedSizes.destination;
      return size.height / destinationSize.height;
  } else if(imageSize.width < size.width){
      return size.width / imageSize.width;
    }
    return 1.0;
  }
  
}

//透明-上下滑动路由效果
class SimpleRoute extends PageRoute {
  SimpleRoute({
    @required this.builder,
  });
  
  final WidgetBuilder builder;
  
  @override
  String get barrierLabel => null;
  
  @override
  bool get opaque => false;
  
  @override
  bool get maintainState => true;
  
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
  
  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    return builder(context);
  }
  
  /// 页面切换动画
  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return SlideTransition(
      position:  Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: const Offset(0.0, 0.0),
      ).animate(CurvedAnimation(parent: animation, curve: Curves.linear)),
      child: builder(context),
    );
    // if(isActive){
    //
    // } else {
    //   //是返回，则不应用过渡动画
    //   return Padding(padding: EdgeInsets.zero);
    // }
    
  }
  
  @override
  Color get barrierColor => null;
}

//透明-缩放路由效果
class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page,})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) => page,
    opaque: false,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) => ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        ),
  );
}