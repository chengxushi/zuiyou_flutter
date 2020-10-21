
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart' as re;
import 'package:zuiyou_flutter/model/post_model.dart';
import 'package:zuiyou_flutter/page/read/provider/read_provider.dart';
import 'package:zuiyou_flutter/page/read/widget/my_refresh_header.dart';
import 'package:zuiyou_flutter/page/read/widget/post_item.dart';
import 'package:zuiyou_flutter/res/app_color.dart';
import 'package:time/time.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/23
/// @email  a12162266@163.com

class ReadChildPage extends StatefulWidget {
  @override
  ReadChildPageState createState() => ReadChildPageState();
}

class ReadChildPageState extends State<ReadChildPage> with AutomaticKeepAliveClientMixin{
  PostModel _postModel;
  ReadProvider readProvider;
  final double _maxDragOffset = 80;
  ScrollController _scrollController;
  final GlobalKey<re.PullToRefreshNotificationState> key = GlobalKey<re.PullToRefreshNotificationState>();

  @override
  void initState() {
    super.initState();
    _postModel = PostModel(
      head: 'https://sf3-ttcdn-tos.pstatp.com/img/user-avatar/fef4e13511ca2df5e92a8f83ca7cad57~120x256.image',
      nickname: '无意穿堂风',
      identityTag: '正能量萌新Yo主',
      attention: true,
      title: '该说不说, 农夫山泉这个搞的真不错',
      images: <String>[
        'https://file.izuiyou.com/img/view/id/1311733247',
        'https://file.izuiyou.com/img/view/id/1311733248',
        'https://file.izuiyou.com/img/view/id/1311733249',
      ],
      label: '最右每日讨论',
      topComment: TopComment(
        likeCount: 29120,
        content: '空山不见人,\n但闻人语响。\n返景入深林, \n复照青苔上。',
      ),
      transpondCount: 780,
      commentCount: 1520,
      likeCount: 35251,
    );
    readProvider = ReadProvider();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: re.PullToRefreshNotification(
        key: key,
        notificationPredicate: (ScrollNotification notification){
          print('notification.metrics.pixels===${notification.metrics.pixels}');
          return true;
        },
        child: LoadingMoreCustomScrollView(
          controller: _scrollController,
          physics: const re.AlwaysScrollableClampingScrollPhysics(),
          slivers: <Widget>[
            re.PullToRefreshContainer(buildPulltoRefreshHeader),
            LoadingMoreSliverList(
              SliverListConfig<PostModel>(
                itemBuilder: (BuildContext context, PostModel model, int index) {
                  return PostItem(postModel: model);
                },
                sourceList: readProvider,
                indicatorBuilder: (BuildContext context, IndicatorStatus status) {
                  print('====status=$status');
                  Widget child;
                  switch (status) {
                    case IndicatorStatus.fullScreenBusying:
                      child = const SliverFillRemaining(child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CupertinoActivityIndicator(),
                        ),
                      ),);
                      break;
                    case IndicatorStatus.loadingMoreBusying:
                      child =  const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                      break;
                    case IndicatorStatus.noMoreLoad:
                      child =  const Center(child: Text('已经没有更多了'));
                      break;
                    case IndicatorStatus.error:
                      BotToast.showText(text: '加载错误');
                      child =  const Center(child: Text('加载错误'));
                      break;
                    case IndicatorStatus.fullScreenError:
                    case IndicatorStatus.empty:
                      child =  SliverFillRemaining(
                        child: Center(
                            child: OutlineButton(
                              onPressed: () async {
                                BotToast.showText(text: '重新加载');
                                await readProvider.refresh(true);
                              },
                              child: Text('没有数据'),
                            )),
                      );
                      break;
                    case IndicatorStatus.none:
                      child =  const SizedBox();
                      break;
                  }
                  return child;
                },
              ),
            ),
          ],
        ),
        onRefresh: readProvider.refresh,
        color: Colors.blue,
        maxDragOffset: _maxDragOffset,
        pullBackDuration: const Duration(milliseconds: 200),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          if(_scrollController.offset == 0.0){
            key.currentState.show(notificationDragOffset: _maxDragOffset);
          } else {
            _scrollController.jumpTo(0.0);
          }
        },
        child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 1.0, offset: Offset(1.0,1.0),), ],
          ),
          child: const Icon(Icons.refresh, color: AppColor.theme_blue, size: 26,),
        ),
      ),
      
    );
  }

  Widget buildPulltoRefreshHeader(re.PullToRefreshScrollNotificationInfo info) {
    return SliverToBoxAdapter(
      child: MyRefreshHeader(info, _maxDragOffset),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

