import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zuiyou_flutter/page/me/provider/me_provider.dart';
import 'package:zuiyou_flutter/widget/load_image.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/23
/// @email  a12162266@163.com

class MePage extends StatefulWidget {
  @override
  MePageState createState() => MePageState();
}

class MePageState extends State<MePage> with AutomaticKeepAliveClientMixin{
  final ScrollController _controller = ScrollController();

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
    print('MePage重新构建');
    super.build(context);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => MeProvider(name: '一方ᥬ᭄', isVip: true, sex: 0, avatar: 'https://avatars0.githubusercontent.com/u/50852805?s=400&u=9a79291231aaa02762dde3c9b9edc64b4fbb1017&v=4'),
        child: Consumer<MeProvider>(
          builder: (BuildContext context, MeProvider meProvider, Widget child){
            return CupertinoScrollbar(
              child: SingleChildScrollView(
                controller: _controller,
                child: Column(
                  children: [
                    Container(
                      color: const Color(0xFF7D96AA),
                      child: Column(
                        children: [
                          SafeArea(
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(context.select((MeProvider value) => value.name), style: const TextStyle(fontSize: 18, color: Colors.white,),),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: const Icon(Icons.settings, color: Colors.white, size: 16,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 14, top: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                  child: ClipOval(
                                    child: LoadImage(context.select((MeProvider value) => value.avatar), width: 70, height: 70, ),
                                  ),
                                ),
                                const Expanded(child: SizedBox(),),
                                if(context.select((MeProvider value) => value.isVip)) Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20),),
                                  ),
                                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.shopping_cart, size: 20, color: Colors.yellow,),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4,),
                                        child: Text('最右会员', style: TextStyle(fontSize: 14, color: Colors.white,),),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, left: 14),
                            child: Row(
                              children: [
                                Text(context.select((MeProvider value) => value.name), style: const TextStyle(fontSize: 18, color: Colors.white,),),
                                const Icon(Icons.nature_people, color: Colors.black, size: 20,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        OutlineButton(
                          onPressed: () {
                            context.read<MeProvider>().changeName('改变后');
                          },
                          child: Text('改变名字'),
                        ),
                        OutlineButton(
                          onPressed: () {
                            // context.read<MeProvider>().changeAvatar('ic_head');
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage(meProvider)));
                          },
                          child: const Text('改变头像'),
                        ),
                        OutlineButton(
                          onPressed: () {
                            context.read<MeProvider>().changeIsVip(false);
                          },
                          child: Text('改变会员'),
                        ),
                      ],
                    ),
                    Container(
                      height: 1500,
                      color: Colors.amberAccent,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
  Widget _infoWidget(){
  
  }

  @override
  bool get wantKeepAlive => true;
}

class NextPage extends StatelessWidget {
  const NextPage(this.meProvider);
  
  final MeProvider meProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: meProvider,
      child: Builder(
        builder: (context){
          return Scaffold(
            body: Center(
              child: LoadImage(context.watch<MeProvider>().avatar),
            ),
            floatingActionButton: OutlineButton(
              onPressed: () {
                context.read<MeProvider>().changeAvatar('ic_head');
              },
              child: Text('改变头像', ),
            ),
          );
        },
      ),
    );
  }
}