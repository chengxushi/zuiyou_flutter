import 'package:flutter/material.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/15
/// @email  a12162266@163.com

class MeProvider with ChangeNotifier{
  MeProvider({
    this.name,
    this.sex,
    this.isVip,
    this.avatar,
  });
  
  String name;
  int sex;
  bool isVip;
  String avatar;
  
  void changeIsVip(bool value) {
    isVip = value;
    notifyListeners();
  }
  void changeName(String value){
    name = value;
    notifyListeners();
  }
  void changeAvatar(String value){
    avatar = value;
    notifyListeners();
  }
}