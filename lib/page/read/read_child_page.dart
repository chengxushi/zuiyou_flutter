import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/widget/skeleton.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/23
/// @email  a12162266@163.com

class ReadChildPage extends StatefulWidget {
  @override
  ReadChildPageState createState() => new ReadChildPageState();
}

class ReadChildPageState extends State<ReadChildPage> with AutomaticKeepAliveClientMixin{

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
    super.build(context);
    return Scaffold(
      body: SkeletonList(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}