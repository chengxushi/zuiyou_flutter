import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/model/post_model.dart';
import 'package:zuiyou_flutter/res/app_color.dart';
import 'package:zuiyou_flutter/widget/expandable_text.dart';
import 'package:zuiyou_flutter/widget/load_image.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/12
/// @email  a12162266@163.com

class PostComment extends StatefulWidget {
  const PostComment(this.comment, {Key key,}) : super(key: key);
  
  final TopComment comment;
  @override
  PostCommentState createState() => PostCommentState();
}

class PostCommentState extends State<PostComment> {
  bool isUp = false;
  bool isDown = false;
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color(0xFFF4F4F6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const LoadImage('ic_comment_god_flag', height: 16, fit: BoxFit.cover,),
              const Expanded(child: SizedBox()),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    isUp = !isUp;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: LoadImage(
                    isUp ? 'ic_godreview_up_selected' : 'ic_godreview_up',
                    height: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(widget.comment.likeCount.toString(), style: const TextStyle(color: AppColor.theme_blue),),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    isDown = !isDown;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: LoadImage(
                    isDown ? 'ic_godreview_down_selected' : 'ic_godreview_down',
                    height: 16,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpandableText(widget.comment.content, style: const TextStyle(fontSize: 16, color: Colors.black,), maxLines: 3,),
              ],
            ),
          )
        ],
      ),
    );
  }
}