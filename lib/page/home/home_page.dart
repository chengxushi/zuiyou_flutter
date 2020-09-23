import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zuiyou_flutter/common/routers/router_util.dart';
import 'package:zuiyou_flutter/common/routers/routers.dart';
import 'package:zuiyou_flutter/common/utils/theme_utils.dart';
import 'package:zuiyou_flutter/page/home/provider/home_provider.dart';
import 'package:zuiyou_flutter/page/read/read_page.dart';
import 'package:zuiyou_flutter/res/app_color.dart';
import 'package:zuiyou_flutter/widget/double_tap_exit_app.dart';
import 'package:zuiyou_flutter/widget/load_image.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/21
/// @email  a12162266@163.com

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static const double _imageSize = 25.0;
  final PageController _pageController = PageController();
  HomeProvider _provider = HomeProvider();
  List<Widget> _pageList;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  void initData() {
    _pageList = <Widget>[
      ReadPage(),
      ReadPage(),
      ReadPage(),
      ReadPage(),
      ReadPage(),
    ];
  }
  
  Widget _item({@required bool isSelected, String image, Color imageColor = AppColor.app_main, String title,}){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LoadAssetImage(isSelected ? image : image+'_selected', width: _imageSize, color: isSelected ? imageColor : Colors.white,),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(title, style: TextStyle(fontSize: 10, color: isSelected ? AppColor.app_main : Colors.white),),
        )
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final bool isDark = ThemeUtils.isDark(context);
    return DoubleTapExitApp(
      child: ChangeNotifierProvider<HomeProvider>(
        create: (_) => _provider,
        child: Scaffold(
          bottomNavigationBar: Consumer<HomeProvider>(
            builder: (_, HomeProvider provider, __){
              return BottomAppBar(
                color: ThemeUtils.getBackgroundColor(context),
                child: Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _pageController.jumpToPage(0),
                      child: _item(isSelected: provider.value == 0, image: 'ic_tab_home', title: '最右'),
                    ),
                    GestureDetector(
                      onTap: () => _pageController.jumpToPage(1),
                      child: _item(isSelected: provider.value == 1, image: 'ic_tab_channel', title: '发现'),
                    ),
                    FloatingActionButton(
                      onPressed: () => _pageController.jumpToPage(2),
                      elevation: 0.0,
                      mini: true,
                      child: Icon(Icons.add, size: 20,),
                    ),
                    _item(isSelected: provider.value == 3, image: 'ic_tab_msg', title: '消息'),
                    _item(isSelected: provider.value == 4, image: 'ic_tab_me', title: '我的'),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
              );
              // return BottomNavigationBar(
              //   items: ,
              //   backgroundColor: ThemeUtils.getBackgroundColor(context),
              //   type: BottomNavigationBarType.fixed,
              //   currentIndex: provider.value,
              //   elevation: 8.0,
              //   iconSize: 21.0,
              //   selectedFontSize: 10,
              //   unselectedFontSize: 10,
              //   selectedItemColor: Theme.of(context).primaryColor,
              //   unselectedItemColor: isDark ? AppColor.unselected_item_color : AppColor.unselected_item_color,
              //   onTap: (int index) => _pageController.jumpToPage(index),
              // );
            },
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(), // 禁止滑动
            controller: _pageController,
            onPageChanged: (int index) => _provider.value = index,
            children: _pageList,
          ),
        ),
      ),
    );
  }
}