import 'dart:convert' show json;

import 'package:zuiyou_flutter/model/asT.dart';
import 'package:zuiyou_flutter/model/post_model.dart';

class PostDataModel {
  PostDataModel({
    this.postList,
  });
  
  factory PostDataModel.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    
    final List<PostModel> postList =
    jsonRes['postList'] is List ? <PostModel>[] : null;
    if (postList != null) {
      for (final dynamic item in jsonRes['postList']) {
        if (item != null) {
          postList.add(PostModel.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }
    return PostDataModel(
      postList: postList,
    );
  }
  
  List<PostModel> postList;
  
  Map<String, dynamic> toJson() => <String, dynamic>{
    'postList': postList,
  };
  @override
  String toString() {
    return json.encode(this);
  }
}
