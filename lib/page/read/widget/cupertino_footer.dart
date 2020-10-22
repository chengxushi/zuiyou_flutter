import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/21
/// @email  a12162266@163.com

class CupertinoFooter extends Footer {
  
  CupertinoFooter({
    this.displacement = 40.0,
    completeDuration = const Duration(seconds: 1),
    bool enableHapticFeedback = false,
    bool enableInfiniteLoad = true,
  }): super(
    float: true,
    extent: 52.0,
    triggerDistance: 52.0,
    completeDuration: completeDuration == null
        ? const Duration(milliseconds: 300,)
        : completeDuration + const Duration(milliseconds: 300,),
    enableHapticFeedback: enableHapticFeedback,
    enableInfiniteLoad: enableInfiniteLoad,
  );
  
  final double displacement;
  final LinkFooterNotifier linkNotifier = LinkFooterNotifier();

  @override
  Widget contentBuilder(
    BuildContext context,
    LoadMode loadState, //加载状态
    double pulledExtent, //拉动距离
    double loadTriggerPullDistance, //触发加载距离
    double loadIndicatorExtent, //footer的高度
    AxisDirection axisDirection,
    bool float, //是否浮动
    Duration completeDuration, //完成延迟
    bool enableInfiniteLoad, //是否开启无限加载
    bool success, //加载是否成功
    bool noMore, //是否没有更多
  ) {
    linkNotifier.contentBuilder(context, loadState, pulledExtent,
        loadTriggerPullDistance, loadIndicatorExtent, axisDirection, float,
        completeDuration, enableInfiniteLoad, success, noMore);
    return CupertinoFooterWidget(linkNotifier: linkNotifier,);
  }
}

// class CupertinoFooterWidget extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Stack(
//         children: [
//           Positioned(
//             left: 0.0,
//             right: 0.0,
//             top: 10,
//             child: Container(
//               alignment: Alignment.center,
//               child: const CupertinoActivityIndicator(radius: 14,),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CupertinoFooterWidget extends StatefulWidget {

  const CupertinoFooterWidget({Key key, this.linkNotifier}) : super(key: key);

  final LinkFooterNotifier linkNotifier;

  @override
  CupertinoFooterWidgetState createState() => CupertinoFooterWidgetState();
}

class CupertinoFooterWidgetState extends State<CupertinoFooterWidget> {
  LoadMode get _refreshState => widget.linkNotifier.loadState;
  double get _pulledExtent => widget.linkNotifier.pulledExtent;
  double get _riggerPullDistance => widget.linkNotifier.loadTriggerPullDistance;
  AxisDirection get _axisDirection => widget.linkNotifier.axisDirection;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 10,
            child: Container(
              alignment: Alignment.center,
              child: const CupertinoActivityIndicator(radius: 14,),
            ),
          ),
        ],
      ),
    );
  }
}