import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/common/utils/image_utils.dart';
import 'package:zuiyou_flutter/model/post_model.dart';
import 'package:zuiyou_flutter/page/read/widget/post_comment.dart';
import 'package:zuiyou_flutter/page/read/widget/post_image.dart';
import 'package:zuiyou_flutter/res/app_color.dart';
import 'package:zuiyou_flutter/widget/button_border.dart';
import 'package:zuiyou_flutter/widget/load_image.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/12
/// @email  a12162266@163.com

class PostItem extends StatefulWidget {
  
  const PostItem({Key key, @required this.postModel}) : super(key: key);
  
  final PostModel postModel;
  @override
  PostItemState createState() => PostItemState();
}

class PostItemState extends State<PostItem> {
  bool _isLike = false;
  bool _isHate = false;
  
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
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10,),
      decoration: BoxDecoration(
        color: Colors.white,
        border: BorderDirectional(
          top: BorderSide(
            width: 5,
            color: Colors.grey[200],
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage: ImageUtils.getImageProvider(widget.postModel.head, holderImg: 'ic_head'),
              ),
              const Padding(padding: EdgeInsets.only(left: 8)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.postModel.nickname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.text_title,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if(widget.postModel.identityTag.isNotEmpty) Text(
                      widget.postModel.identityTag,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              ButtonBorder(
                onTop: (){},
                text: '+关注',
                textSize: 14,
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              ),
              GestureDetector(
                onTap: (){print('关闭');},
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.only(left: 10, right: 8, top: 10, bottom: 10),
                  child: Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,),
            child: Text(
              widget.postModel.title,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if(widget.postModel.images?.isNotEmpty ?? false) PostImage(imageList: widget.postModel.images),
          if(widget.postModel.videos?.isNotEmpty ?? false) PostImage(imageList: widget.postModel.images),
          InputChip(
            onPressed: (){},
            backgroundColor: const Color(0xFFF0F9FE),
            avatar: const CircleAvatar(radius: 8, child: Text('#', style: TextStyle(fontSize: 12, color: Colors.white),), backgroundColor: AppColor.theme_blue,),
            label: Text(widget.postModel.label, style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold,),),
            labelPadding: const EdgeInsets.only(left: 4),
            deleteIcon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 10,),
            onDeleted: (){},
            elevation: 1,
          ),
          if(widget.postModel.topComment != null) PostComment(widget.postModel.topComment),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const LoadImage('icon_post_share', height: 26,),
                    Text(widget.postModel.transpondCount.toString(), style: const TextStyle(color: Colors.black87,),),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const LoadImage('icon_post_comment', height: 22,),
                    Text(widget.postModel.commentCount.toString(), style: const TextStyle(color: Colors.black87,),),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _isLike = !_isLike;
                        });
                      },
                      child: LoadImage(
                        _isLike ? 'icon_post_like_hl' : 'icon_post_like',
                        height: 20,
                      ),
                    ),
                    Text(widget.postModel.commentCount.toString(), style: const TextStyle(color: Colors.black87,),),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isHate = !_isHate;
                        });
                      },
                      child: LoadImage(
                        _isHate ? 'icon_post_hate_hl' : 'icon_post_hate',
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

