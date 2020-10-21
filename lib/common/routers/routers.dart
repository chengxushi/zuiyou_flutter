import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:zuiyou_flutter/common/routers/router_provider.dart';
import 'package:zuiyou_flutter/page/home/home_page.dart';
import 'package:zuiyou_flutter/page/home/splash_page.dart';

import 'not_found_page.dart';

// ignore: avoid_classes_with_only_static_members
/// @description
/// @Created by huang
/// @Date   2020/9/16
/// @email  a12162266@163.com

// final Router router = Router();
// const String home = '/home';
// final List<RouterProvider> _listRouter = <RouterProvider>[];
// void initRoutes(){
//   router.notFoundHandler = Handler(
//       handlerFunc: (BuildContext context, Map<String, List<String>> params){
//         debugPrint('找不到路由, 404');
//         return ;
//       }
//   );
//
//   //路由页面配置
//   // 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是转场动画
//   router.define(home, handler: Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params){
//       return HomePage();
//     },
//   ));
//
//   _listRouter.clear();
//   /// 各自路由由各自模块管理，统一在此添加初始化
// //    _listRouter.add();
//   /// 初始化路由
//   for(final RouterProvider routerProvider in _listRouter){
//     routerProvider.initRouter(router);
//   }
// }
class Routers {
  static final fluro.Router router = fluro.Router();
  static final List<RouterProvider> _listRouter = <RouterProvider>[];
  static const String home = '/home';
  static const String splash = '/splash';

  static void initRoutes(){
    router.notFoundHandler = fluro.Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params){
          debugPrint('找不到路由, 404');
          return NotFoundPage();
        }
    );

    //路由页面配置
    // 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是转场动画
    router.define(splash, handler: fluro.Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        return SplashPage();
      },
    ));
    router.define(home, handler: fluro.Handler(
      handlerFunc: (_, __) => HomePage(),
    ));

    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
   // _listRouter.add();
    /// 初始化路由
    for(final RouterProvider routerProvider in _listRouter){
      routerProvider.initRouter(router);
    }
  }
}

