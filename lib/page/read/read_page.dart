import 'package:flutter/material.dart';
import 'read_child_page.dart';
import 'package:zuiyou_flutter/widget/tab_bar_my.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/22
/// @email  a12162266@163.com

class ReadPage extends StatefulWidget {
  @override
  ReadPageState createState() => ReadPageState();
}

class ReadPageState extends State<ReadPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  List<String> _tabList = <String>[];
  List<Widget> _tabViewList = <Widget>[];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
  
  void initData() {
    _tabList = <String>['关注', '话题', '推荐', '视频', '图文', '语玩', '游戏', '汉服'];
    for(int i = 0; i < _tabList.length; i++){
      if(i == 2){
        _tabViewList.add(ReadChildPage());
      } else {
        _tabViewList.add(Center(child: Text(_tabList[i]),));
      }
    }
    _tabController = TabController(initialIndex: 2, length: _tabList.length, vsync: this);
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TabBar(
                      tabs: _tabList.map((e) => Tab(text: e,)).toList(),
                      isScrollable: true,
                      controller: _tabController,
                      labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600,),
                      unselectedLabelStyle: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600,),
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: Colors.transparent,
                      labelPadding: const EdgeInsets.only(left: 8, right: 8),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.search, size: 24,),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey[300], height: 0.5,),
            Expanded(
              child: TabBarView(
                children: _tabViewList,
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}