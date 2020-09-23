import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zuiyou_flutter/common/utils/theme_utils.dart';

/// @description  骨架图
/// @Created by huang
/// @Date   2020/9/23
/// @email  a12162266@163.com

class SkeletonBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final double height = 10;
     final Color color = Colors.grey;
     // final BorderRadius borderRadius = BorderRadius.circular(6);
     final BoxDecoration boxDecoration = BoxDecoration(color: color, borderRadius: BorderRadius.circular(6),);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                radius: 18,
                backgroundColor: color,
              ),
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: height,
                      width: 60,
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: boxDecoration,
                    ),
                    Container(
                      height: height,
                      width: 40,
                      decoration: boxDecoration,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: height,
            width: double.infinity,
            margin: EdgeInsets.only(top: 12),
            decoration: boxDecoration,
          ),
          Container(
            height: height,
            width: 200,
            margin: EdgeInsets.only(top: 12),
            decoration: boxDecoration,
          ),
          Container(
            height: 100,
            width: double.infinity,
            margin: EdgeInsets.only(top: 16, bottom: 24),
            decoration: boxDecoration,
          ),
        ],
      ),
    );
  }
}

class SkeletonList extends StatelessWidget {
  
  const SkeletonList({Key key, this.length: 4}) : super(key: key);
  
  final int length;
  
  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    List<Widget> itemList = [];
    for(int i = 0; i < length; i++){
      itemList.add(SkeletonBox());
    }
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        child: Column(
          children: itemList,
        ),
        baseColor: isDark ? Colors.grey[700] : Color(0xFFC6C6C6),
        highlightColor: isDark ? Colors.grey[500] : Colors.grey[800],
        period: const Duration(milliseconds: 2000),
      ),
    );
  }
  
}