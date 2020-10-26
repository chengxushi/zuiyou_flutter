import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/model/post_data_model.dart';
import 'package:zuiyou_flutter/model/post_model.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/22
/// @email  a12162266@163.com

class ReadProvider with ChangeNotifier{
  
  ReadProvider(this._context);
  
  final BuildContext _context;
  List<PostModel> postModelList = [];
  bool loading = false;
  
  Future<void> loadData() async {
    loading = true;
    Future.delayed(Duration(seconds: 2), () async {
      await DefaultAssetBundle.of(_context).loadString('assets/json/post_data.json').then((value){
        if(value != null){
          final PostDataModel postDataModel = PostDataModel.fromJson(json.decode(value) as Map<String, dynamic>);
          postModelList.clear();
          postDataModel.postList.forEach((element) {
            postModelList.add(element);
          });
        }
        loading = false;
        notifyListeners();
      });
    });
  }
  
  Future<void> loadMore() async {
    await DefaultAssetBundle.of(_context).loadString('assets/json/post_data_2.json').then((value){
      if(value != null){
        final PostDataModel postDataModel = PostDataModel.fromJson(json.decode(value) as Map<String, dynamic>);
        postDataModel.postList.forEach((element) {
          postModelList.add(element);
        });
      }
      notifyListeners();
    });
  }
}