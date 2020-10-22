import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/common/info/device_info.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/22
/// @email  a12162266@163.com

class PostVideo extends StatefulWidget {
  const PostVideo({Key key, @required this.videoList,}) : super(key: key);
  final List<String> videoList;
  @override
  PostVideoState createState() => PostVideoState();
}

class PostVideoState extends State<PostVideo> {
  double _videoWidth;
  int _videoLength;
  final List<String> _tagList = <String>[];
  var s = Random.secure();

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
    return GridView.builder(
      padding: const EdgeInsets.only(top: 8, right: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _videoLength,
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: _videoWidth,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index){
        final String heroTag = widget.videoList[index] + '随机数: ${s.nextDouble()}';
        _tagList.add(heroTag);
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: GestureDetector(
            onTap: () {},
            child: Hero(
              tag: heroTag,
              child: null,
            ),
          ),
        );
      },
    );
  }
}