import 'dart:async';
import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/common/info/device_info.dart';

/// @description
/// @Created by huang
/// @Date   2020/4/1
/// @email  a12162266@163.com

class PhotoPlay extends StatefulWidget {
  const PhotoPlay({
    Key key,
    this.pics,
    this.tagList,
    this.index,
  }) : super(key: key);

  final List<String> pics;
  final List<String> tagList;
  final int index;

  @override
  PhotoPlayState createState() => PhotoPlayState();
}

class PhotoPlayState extends State<PhotoPlay> {
  final rebuildIndex = StreamController<int>.broadcast();
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedImageSlidePage(
      slideAxis: SlideAxis.both,
      slideType: SlideType.wholePage,
      slidePageBackgroundHandler: (Offset offset, Size pageSize){
      
      },
      child: ExtendedImageGesturePageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: ExtendedImage.network(
              widget.pics[index],
              //开启滑动退出页面效果
              enableSlideOutPage: true,
              fit: BoxFit.contain,
              mode: ExtendedImageMode.gesture,
              heroBuilderForSlidingPage: (Widget result) {
                //Hero动画效果
                return Hero(
                  tag: widget.tagList[widget.index],
                  child: result,
                  flightShuttleBuilder: (BuildContext flightContext, Animation<double> animation,
                      HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext) {
                    final Hero hero = (
                        flightDirection == HeroFlightDirection.pop ? fromHeroContext.widget : toHeroContext.widget
                    ) as Hero;
                    return hero.child;
                  },
                );
              },
              initGestureConfigHandler: (ExtendedImageState state) {
                //大图自适应放大
                double initialScale = 1.0;
                if (state.extendedImageInfo != null &&
                    state.extendedImageInfo.image != null) {
                  initialScale = initScale(
                      initialScale: initialScale,
                      imageSize: Size(
                          state.extendedImageInfo.image.width.toDouble(),
                          state.extendedImageInfo.image.height.toDouble()));
                }
                return GestureConfig(
                  inPageView: true,
                  initialScale: initialScale,
                  maxScale: max(initialScale, 5.0),
                  animationMaxScale: max(initialScale, 5.0),
                  initialAlignment: InitialAlignment.topCenter,
                  //you can cache gesture state even though page view page change.
                  //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                  cacheGesture: false,
                );
              },
            ),
          );
        },
        controller: PageController(
          initialPage: widget.index,
        ),
        itemCount: widget.pics.length,
        onPageChanged: (int index) {
          _currentIndex = index;
          rebuildIndex.add(index);
        },
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  double initScale({Size imageSize, double initialScale}) {
    final Size size = DeviceInfo.size;
    final double n1 = imageSize.height / imageSize.width;
    final double n2 = size.height / size.width;
    if (n1 > n2) {
      final FittedSizes fittedSizes =
          applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      final Size destinationSize = fittedSizes.destination;
      return size.width / destinationSize.width;
    } else if (n1 / n2 < 1 / 4) {
      final FittedSizes fittedSizes =
          applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      final Size destinationSize = fittedSizes.destination;
      return size.height / destinationSize.height;
    }

    return initialScale;
  }

  @override
  void dispose() {
    rebuildIndex.close();
    super.dispose();
  }
}
