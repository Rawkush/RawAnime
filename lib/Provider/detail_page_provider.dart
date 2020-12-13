import 'package:flutter/cupertino.dart';
import 'package:myapp/Model/episode_model.dart';

class DetailPageProvider with ChangeNotifier{
  List<Episode> _episodeList=[
    Episode("1", "https://cloud.video.taobao.com/play/u/3954377811/p/1/e/6/t/10301/211251046834.mp4","https://images.unsplash.com/photo-1577401749907-4613bde19b2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",),
    Episode("2", "https://cloud.video.taobao.com/play/u/3954377811/p/1/e/6/t/10301/211251046834.mp4","https://images.unsplash.com/photo-1577401749907-4613bde19b2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",),
    Episode("3", "https://cloud.video.taobao.com/play/u/3954377811/p/1/e/6/t/10301/211251046834.mp4","https://images.unsplash.com/photo-1577401749907-4613bde19b2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",),
    Episode("4", "https://cloud.video.taobao.com/play/u/3954377811/p/1/e/6/t/10301/211251046834.mp4","https://images.unsplash.com/photo-1577401749907-4613bde19b2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",),
    Episode("5", "https://cloud.video.taobao.com/play/u/3954377811/p/1/e/6/t/10301/211251046834.mp4","https://images.unsplash.com/photo-1577401749907-4613bde19b2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",),
    Episode("6", "https://cloud.video.taobao.com/play/u/3954377811/p/1/e/6/t/10301/211251046834.mp4","https://images.unsplash.com/photo-1577401749907-4613bde19b2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",),
  ];
  
  List<Episode> get episodeList{
    return [..._episodeList];
  }
}