/// @description 
/// @Created by huang
/// @Date   2020/9/23
/// @email  a12162266@163.com

class CardModel {
  String avatar;
  String name;
  String describe;
  bool isVip;
  bool isYo;
  String content;
  List<Avs> avs;
  String sort;
  
}

class Avs {
  String path;
  int type;
  List<String> imageList;
  List<String> videoList;
  
}