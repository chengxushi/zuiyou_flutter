import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/common/info/device_info.dart';
import 'package:zuiyou_flutter/model/video_model.dart';
import 'package:zuiyou_flutter/widget/load_image.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/22
/// @email  a12162266@163.com

class PostVideo extends StatefulWidget {
  const PostVideo({Key key, @required this.videoList, this.indexLocation}) : super(key: key);
  final List<VideoModel> videoList;
  final int indexLocation;
  @override
  PostVideoState createState() => PostVideoState();
}

class PostVideoState extends State<PostVideo> {
  double _videoWidth;
  int _videoLength;
  final List<String> _tagList = <String>[];

  @override
  void initState() {
    super.initState();
    _videoLength = widget.videoList.length;
    _videoWidth = DeviceInfo.screenWidth /
        ((_videoLength == 3 || _videoLength > 4)
            ? 3
            : (_videoLength == 2 || _videoLength == 4) ? 2 : 1.5);
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final String heroTag = widget.videoList[0].cover;
    _tagList.add(heroTag);
    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: GestureDetector(
          onTap: () {
            // Navigator.push(context, SimpleRoute(builder: (context) => VideoPlay(tagList: _tagList,)));
            Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlay(tagList: _tagList,)));
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     opaque: false,
            //     pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) =>
            //         VideoPlay(tagList: _tagList,),
            //   ),
            // );
          },
          child: LoadImage(
            widget.videoList[0].cover,
            fit: BoxFit.cover,
            width: _videoWidth,
            height: _videoWidth,
          ),
          // child: Stack(
          //   children: [
          //     LoadImage(
          //       widget.videoList[0].cover,
          //       fit: BoxFit.cover,
          //       width: _videoWidth,
          //       height: _videoWidth,
          //     ),
          //     Center(child: Icon(CupertinoIcons.play_fill, color: Colors.white, size: 36,),),
          //   ],
          // ),
        ),
      ),
    );
    // return GridView.builder(
    //   padding: const EdgeInsets.only(top: 8, right: 10),
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemCount: _videoLength,
    //   shrinkWrap: true,
    //   primary: false,
    //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //     maxCrossAxisExtent: _videoWidth,
    //     crossAxisSpacing: 2.0,
    //     mainAxisSpacing: 2.0,
    //     childAspectRatio: 1,
    //   ),
    //   itemBuilder: (BuildContext context, int index){
    //     final String heroTag ='$index${widget.indexLocation}';
    //     print(heroTag);
    //     _tagList.add(heroTag);
    //     return Hero(
    //       tag: heroTag,
    //       child: ClipRRect(
    //         borderRadius: BorderRadius.circular(4),
    //         child: GestureDetector(
    //           onTap: () {
    //             // Navigator.push(context, SimpleRoute(builder: (context) => VideoPlay(tagList: _tagList,), name: '111', title: '222'));
    //
    //             Navigator.push(
    //               context,
    //               PageRouteBuilder(
    //                 opaque: false,
    //                 transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
    //                 pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) =>
    //                     FadeTransition(opacity: animation, child: VideoPlay(tagList: _tagList,),),
    //               ),
    //             );
    //           },
    //           child: Stack(
    //             children: [
    //               LoadImage(
    //                 widget.videoList[index].cover,
    //                 fit: BoxFit.cover,
    //                 width: _videoWidth,
    //                 height: _videoWidth,
    //               ),
    //               Center(child: Icon(CupertinoIcons.play_fill, color: Colors.white, size: 36,),),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

class VideoPlay extends StatefulWidget {
  const VideoPlay({
    Key key,
    this.tagList,
  }) : super(key: key);
  final List<String> tagList;
  @override
  VideoPlayState createState() => VideoPlayState();
}
class VideoPlayState extends State<VideoPlay> {

  @override
  void initState() {
    super.initState();
    print(widget.tagList);
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Hero(
        tag: widget.tagList[0],
        child: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Center(
            child: Container(
              color: Colors.yellow,
              height: 200,
              width: 200,
              child: LoadImage(widget.tagList[0]),
            ),
          ),
        ),
      ),
    );
  }
}

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
        begin: Offset(0.0, 1.0),
        end: Offset(0.0, 0.0),
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