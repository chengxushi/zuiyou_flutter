import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/res/app_color.dart';

/// @description  有边框的圆角按钮
/// @Created by huang
/// @Date   2020/7/14
/// @email  a12162266@163.com

class ButtonBorder extends StatelessWidget {
  
  const ButtonBorder({
    Key key,
    @required this.onTop,
    this.text = '确定',
    this.textColor = AppColor.theme_blue,
    this.textSize = 14,
    this.margin,
    this.borderColor = AppColor.theme_blue,
    this.borderWidth = 1,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.width,
    this.height,
  }) : super(key: key);
  
  final GestureTapCallback onTop;
  final String text;
  final Color textColor;
  final double textSize;
  final EdgeInsetsGeometry margin;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double height;
  final double width;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTop,
      child: Container(
        padding: padding,
        margin: margin,
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(text, style: TextStyle(fontSize: textSize, color: textColor),),
      ),
    );
  }
}