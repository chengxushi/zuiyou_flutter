import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:zuiyou_flutter/common/routers/routers.dart';
import 'package:zuiyou_flutter/provider/theme_provider.dart';

import 'page/home/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  // 透明状态栏
  // if (Platform.isAndroid) {
  //   const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // }
}

class MyApp extends StatelessWidget {

  MyApp({this.theme}) {
    Routers.initRoutes();
  }

  final ThemeData theme;
  
  @override
  Widget build(BuildContext context) {
    ///调用 BotToastInit
    final TransitionBuilder botToastBuilder = BotToastInit();
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (_, ThemeProvider provider, __) {
          return MaterialApp(
            title: 'Flutter最右',
            home: SplashPage(),
            theme: theme ?? provider.getTheme(),
            darkTheme: provider.getTheme(isDarkMode: false),
            themeMode: provider.getThemeMode(),
            onGenerateRoute: Routers.router.generator, //配置fluro
            builder: (BuildContext context, Widget child) {
              child = botToastBuilder(context, child);
              /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child,
              );
            },
            navigatorObservers: <NavigatorObserver>[
              //Toast-注册路由观察者
              BotToastNavigatorObserver(),
            ],
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const <Locale>[
              Locale('zh', 'CN'),
              Locale('en', 'US')
            ],
          );
        },
      ),
    );
  }
}
