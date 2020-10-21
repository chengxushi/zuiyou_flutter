import 'package:loading_more_list/loading_more_list.dart';
import 'package:zuiyou_flutter/model/post_model.dart';
import 'package:time/time.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/19
/// @email  a12162266@163.com

class ReadProvider extends LoadingMoreBase<PostModel>{
  int pageIndex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;

  final PostModel model = PostModel(
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
  @override
  bool get hasMore => (_hasMore && length < 5) || forceRefresh;
  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    bool isSuccess = false;
    await 2.seconds.delay;
    add(model);
    add(model);
    pageIndex++;
    isSuccess = true;
    return isSuccess;
  }
  
  //重新加载与刷新
  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    print('刷新' * 4);
    _hasMore = true;
    pageIndex = 1;
    clear();
    final bool result = await super.refresh(notifyStateChanged);
    return result;
  }
}