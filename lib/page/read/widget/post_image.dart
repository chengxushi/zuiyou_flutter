
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/common/info/device_info.dart';
import 'package:zuiyou_flutter/widget/load_image.dart';
/// @description
/// @Created by huang
/// @Date   2020/10/12
/// @email  a12162266@163.com

class PostImage extends StatefulWidget {
  
  const PostImage({Key key, @required this.imageList}) : super(key: key);
  
  final List<String> imageList;
  @override
  PostImageState createState() => PostImageState();
}

class PostImageState extends State<PostImage> {
  int _imageLength;
  double imageWidth;
  
  @override
  void initState() {
    super.initState();
    _imageLength = widget.imageList.length;
    imageWidth = DeviceInfo.screenWidth /
        ((_imageLength == 3 || _imageLength > 4)
            ? 3
            : (_imageLength == 2 || _imageLength == 4) ? 2 : 1.5);
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
      itemCount: _imageLength,
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: imageWidth,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index){
        final String heroTag = widget.imageList[index] + Random.secure().toString();
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: GestureDetector(
            onTap: (){
            
            },
            child: Hero(
              tag: heroTag,
              child: LoadImage(
                widget.imageList[index],
                fit: BoxFit.cover,
                width: imageWidth,
                height: imageWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}