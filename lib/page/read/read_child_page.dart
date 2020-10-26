
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'package:zuiyou_flutter/model/post_model.dart';
import 'package:zuiyou_flutter/model/video_model.dart';
import 'package:zuiyou_flutter/page/read/provider/read_provider.dart';
import 'package:zuiyou_flutter/page/read/widget/cupertino_footer.dart';
import 'package:zuiyou_flutter/page/read/widget/image_header.dart';
import 'package:zuiyou_flutter/page/read/widget/material_header.dart';
import 'package:zuiyou_flutter/page/read/widget/post_item.dart';
import 'package:time/time.dart';
import 'package:zuiyou_flutter/widget/skeleton.dart';

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
  PostModel _postModel2;
  ScrollController _scrollController;
  List<PostModel> _modelList;
  ReadProvider _readProvider;

  @override
  void initState() {
    super.initState();
    _readProvider = ReadProvider(context);
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
    _postModel2 = PostModel(
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
      videos: <VideoModel>[
        VideoModel(),
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
    _modelList = [];
    _modelList.addAll([
      _postModel,
      _postModel,
      _postModel,
    ]);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    _readProvider.loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => _readProvider,
        child: Consumer<ReadProvider>(
          builder: (BuildContext context, ReadProvider readProvider, Widget child){
            if(_readProvider.postModelList.isEmpty){
              return const SkeletonList();
            } else{
              return EasyRefresh(
                child: ListView.builder(
                  itemCount: _readProvider.postModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PostItem(postModel: _readProvider.postModelList[index], indexLocation: index,);
                  },
                ),
                header: ImageHeader(),
                footer: CupertinoFooter(),
                onRefresh: _readProvider.loadData,
                onLoad: _readProvider.loadMore,
              );
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

