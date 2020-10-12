import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:time/time.dart';
import 'package:zuiyou_flutter/common/info/device_info.dart';
import 'package:zuiyou_flutter/common/utils/image_utils.dart';
import 'package:zuiyou_flutter/model/post_model.dart';
import 'package:zuiyou_flutter/res/app_color.dart';
import 'package:zuiyou_flutter/widget/button_border.dart';
import 'package:zuiyou_flutter/widget/expandable_text.dart';
import 'package:zuiyou_flutter/widget/load_image.dart';
import 'package:zuiyou_flutter/widget/space_header.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/23
/// @email  a12162266@163.com

class ReadChildPage extends StatefulWidget {
  @override
  ReadChildPageState createState() => ReadChildPageState();
}

class ReadChildPageState extends State<ReadChildPage> with AutomaticKeepAliveClientMixin{
  PostModel _postModel;

  @override
  void initState() {
    super.initState();
    _postModel = PostModel(
      head: 'https://sf3-ttcdn-tos.pstatp.com/img/user-avatar/fef4e13511ca2df5e92a8f83ca7cad57~120x256.image',
      nickname: '无意穿堂风',
      identityTag: '正能量萌新Yo主',
      attention: true,
      title: '该说不说, 农夫山泉这个搞的真不错',
      images: <String>[
        'https://file.izuiyou.com/img/view/id/1311733247',
        'https://file.izuiyou.com/img/view/id/1311733248',
        'https://file.izuiyou.com/img/view/id/1311733249',
      ],
      label: '最右每日讨论',
      topComment: TopComment(
        likeCount: 29120,
        content: '空山不见人,\n但闻人语响。\n返景入深林, \n复照青苔上。',
      ),
      transpondCount: 780,
      commentCount: 1520,
      likeCount: 35251,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: EasyRefresh(
        header: SpaceHeader(),
        footer: MaterialFooter(),
        // firstRefresh: true,
        // firstRefreshWidget: const SkeletonList(),
        onRefresh: () async {
          await 2.seconds.delay;
        },
        onLoad: () async {
          await 2.seconds.delay;
        },
        child: _postItem( _postModel),
      ),
    );
  }
  
  Widget _postItem(PostModel postModel) {
    final int imageLength = postModel.images.length;
    final double imageWidth = (ScreenUtil.getScreenW(context)) /
        ((imageLength == 3 || imageLength > 4)
            ? 3
            : (imageLength == 2 || imageLength == 4) ? 2 : 1.5);
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10,),
      color: Colors.white,
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
                backgroundImage: ImageUtils.getImageProvider(postModel.head, holderImg: 'ic_head'),
              ),
              const Padding(padding: EdgeInsets.only(left: 8)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postModel.nickname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.text_title,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if(postModel.identityTag.isNotEmpty) Text(
                      postModel.identityTag,
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
              postModel.title,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if(postModel.images.isNotEmpty) _imageWidget(postModel.images, imageWidth),
          InputChip(
            onPressed: (){},
            backgroundColor: const Color(0xFFF0F9FE),
            avatar: const CircleAvatar(radius: 8, child: Text('#', style: TextStyle(fontSize: 12, color: Colors.white),), backgroundColor: AppColor.theme_blue,),
            label: Text(postModel.label, style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold,),),
            labelPadding: const EdgeInsets.only(left: 4),
            deleteIcon: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 10,),
            onDeleted: (){},
            elevation: 1,
          ),
          if(postModel.topComment != null)_commentWidget(postModel.topComment),
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
                    Text(postModel.transpondCount.toString(), style: const TextStyle(color: Colors.black87,),),
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
                    Text(postModel.commentCount.toString(), style: const TextStyle(color: Colors.black87,),),
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
                      
                      },
                      child: const LoadImage(
                        'icon_post_like',
                        height: 20,
                      ),
                    ),
                    Text(postModel.commentCount.toString(), style: const TextStyle(color: Colors.black87,),),
                    const LoadImage('icon_post_hate', height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _commentWidget(TopComment comment) {
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
                const LoadImage('ic_godreview_up',height: 16,),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(comment.likeCount.toString(), style: const TextStyle(color: AppColor.theme_blue),),
                ),
                const LoadImage('ic_godreview_down',height: 16,),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandableText(comment.content, style: const TextStyle(fontSize: 16, color: Colors.black,), maxLines: 3,),
                ],
              ),
            )
          ],
        ),
      );
  }
  
  Widget _imageWidget(List<String> imageList, double imageWidth){
    return GridView.builder(
      padding: const EdgeInsets.only(top: 8, right: 10),
      itemCount: imageList.length,
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: imageWidth,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index){
        final String heroTag = imageList[index] + Random.secure().toString();
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: GestureDetector(
            onTap: (){
    
            },
            child: Hero(
              tag: heroTag,
              child: LoadImage(
                imageList[index],
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

  @override
  bool get wantKeepAlive => true;
}