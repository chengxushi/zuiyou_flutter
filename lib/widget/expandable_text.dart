import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/10
/// @email  a12162266@163.com

class ExpandableText extends StatefulWidget {
  const ExpandableText(this.text,
      {Key key, this.maxLines, this.style, this.expand = false, this.onTop,})
      : assert(maxLines >= 1, '最大行数不能为空'),
        super(key: key);

  final String text;
  final int maxLines;
  final TextStyle style;
  final bool expand;
  final GestureTapCallback onTop;
  
  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expand;

  @override
  void initState() {
    super.initState();
    expand = widget.expand;
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    //使用LayoutBuilder控件延迟加载
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        if(isExceedMaxLines(widget.text, constraints)) {
          return GestureDetector(
            onTap: widget.onTop,
            onDoubleTap: (){
              setState(() {
                expand = !expand;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (expand)
                  Text(
                  widget.text,
                  style: widget.style,
                )
                else
                  Text(
                    widget.text,
                    style: widget.style,
                    maxLines: widget.maxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(expand ? '...双击收回' : '...双击展开', style: const TextStyle(fontSize: 14, color: Colors.grey,),),
              ],
            ),
          );
        }
        return GestureDetector(
          onTap: widget.onTop,
          child: Text(
            widget.text,
            style: widget.style,
          ),
        );
      },
    );
  }
  
  //判断文本内容是否超过指定的行数
  bool  isExceedMaxLines(String text, BoxConstraints constraints){
    final TextSpan span = TextSpan(text: text, style: widget.style);
    final TextPainter textPainter = TextPainter(text: span, maxLines: widget.maxLines, textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: constraints.maxWidth);
    return textPainter.didExceedMaxLines;
  }
}