import 'dart:convert' show json;

import 'package:zuiyou_flutter/model/asT.dart';

/// @description
/// @Date  2020-10-22
class VideoModel {
  VideoModel({
    this.cover,
    this.url,
    this.barrage,
  });
  
  
  factory VideoModel.fromJson(Map<String, dynamic> jsonRes)=>jsonRes == null? null:VideoModel(cover : asT<String>(jsonRes['cover']),
    url : asT<String>(jsonRes['url']),
    barrage : BarrageModel.fromJson(asT<Map<String, dynamic>>(jsonRes['barrage'])),
  );
  
  String cover;
  String url;
  BarrageModel barrage;
  
  Map<String, dynamic> toJson() => <String, dynamic>{
    'cover': cover,
    'url': url,
    'barrage': barrage,
  };
  
  @override
  String  toString() {
    return json.encode(this);
  }
}
class BarrageModel {
  BarrageModel({
    this.user,
    this.time,
    this.text,
    this.like,
    this.hate,
  });
  
  
  factory BarrageModel.fromJson(Map<String, dynamic> jsonRes)=>jsonRes == null? null:BarrageModel(user : asT<String>(jsonRes['user']),
    time : asT<String>(jsonRes['time']),
    text : asT<String>(jsonRes['text']),
    like : asT<int>(jsonRes['like']),
    hate : asT<int>(jsonRes['hate']),
  );
  
  String user;
  String time;
  String text;
  int like;
  int hate;
  
  Map<String, dynamic> toJson() => <String, dynamic>{
    'user': user,
    'time': time,
    'text': text,
    'like': like,
    'hate': hate,
  };
  
  @override
  String  toString() {
    return json.encode(this);
  }
}


