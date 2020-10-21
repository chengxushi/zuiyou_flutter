import 'dart:convert' show json;

import 'package:zuiyou_flutter/model/asT.dart';

/// @description
/// @Date  2020-10-09

class PostModel {
  PostModel({
    this.head,
    this.nickname,
    this.attention,
    this.identityTag,
    this.title,
    this.images,
    this.videos,
    this.label,
    this.topComment,
    this.transpondCount,
    this.commentCount,
    this.likeCount,
  });


  factory PostModel.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<String> images = jsonRes['images'] is List ? <String>[] : null;
    if (images != null) {
      for (final dynamic item in jsonRes['images']) {
        if (item != null) {
          images.add(asT<String>(item));
        }
      }
    }

    final List<String> videos = jsonRes['videos'] is List ? <String>[] : null;
    if (videos != null) {
      for (final dynamic item in jsonRes['videos']) {
        if (item != null) {
          videos.add(asT<String>(item));
        }
      }
    }

    return PostModel(
      head: asT<String>(jsonRes['head']),
      nickname: asT<String>(jsonRes['nickname']),
      attention: asT<bool>(jsonRes['attention']),
      identityTag: asT<String>(jsonRes['identityTag']),
      title: asT<String>(jsonRes['title']),
      images: images,
      videos: videos,
      label: asT<String>(jsonRes['label']),
      topComment:
          TopComment.fromJson(asT<Map<String, dynamic>>(jsonRes['topComment'])),
      transpondCount: asT<int>(jsonRes['transpondCount']),
      commentCount: asT<int>(jsonRes['commentCount']),
      likeCount: asT<int>(jsonRes['likeCount']),
    );
  }

  String head; //头像
  ///昵称
  String nickname;
  bool attention; //是否关注
  String identityTag; //身份标志
  String title; //标题
  List<String> images; //图片列表
  List<String> videos; //视频列表
  String label; //标签
  TopComment topComment; //评论详情
  int transpondCount; //转发数量
  int commentCount; //评论数量
  int likeCount; //点赞数量
  
  Map<String, dynamic> toJson() => <String, dynamic>{
    'head': head,
    'nickname': nickname,
    'attention': attention,
    'identityTag': identityTag,
    'title': title,
    'images': images,
    'videos': videos,
    'label': label,
    'topComment': topComment,
    'transpondCount': transpondCount,
    'commentCount': commentCount,
    'likeCount': likeCount,
  };
  
  @override
  String  toString() {
    return json.encode(this);
  }
}
class TopComment {
  TopComment({
    this.likeCount,
    this.content,
    this.images,
    this.videos,
  });
  
  factory TopComment.fromJson(Map<String, dynamic> jsonRes){ if(jsonRes == null){return null;}
  final List<String> images = jsonRes['images'] is List ? <String>[]: null;
  if(images!=null) {
    for (final dynamic item in jsonRes['images']) { if (item != null) { images.add(asT<String>(item));  } }
  }
  
  
  final List<String> videos = jsonRes['videos'] is List ? <String>[]: null;
  if(videos!=null) {
    for (final dynamic item in jsonRes['videos']) { if (item != null) { videos.add(asT<String>(item));  } }
  }
  
  
  return TopComment(likeCount : asT<int>(jsonRes['likeCount']),
    content : asT<String>(jsonRes['content']),
    images:images,
    videos:videos,
  );}
  
  int likeCount;
  String content;
  List<String> images;
  List<String> videos;
  
  Map<String, dynamic> toJson() => <String, dynamic>{
    'likeCount': likeCount,
    'content': content,
    'images': images,
    'videos': videos,
  };
  
  @override
  String  toString() {
    return json.encode(this);
  }
}


