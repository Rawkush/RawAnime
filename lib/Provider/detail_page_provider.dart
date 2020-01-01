import 'package:flutter/cupertino.dart';
import 'package:myapp/Model/episode_model.dart';

class DetailPageProvider with ChangeNotifier{
  List<EpisodeModel> _episodeList=[
    EpisodeModel("1", "https://www.youtube.com/watch?v=hMy5za-m5Ew"),
    EpisodeModel("2", "https://www.youtube.com/watch?v=hMy5za-m5Ew"),
    EpisodeModel("3", "https://www.youtube.com/watch?v=hMy5za-m5Ew"),
    EpisodeModel("4", "https://www.youtube.com/watch?v=hMy5za-m5Ew"),
    EpisodeModel("5", "https://www.youtube.com/watch?v=hMy5za-m5Ew"),
    EpisodeModel("6", "https://www.youtube.com/watch?v=hMy5za-m5Ew"),
  ];
  

  List<EpisodeModel> get episodeList{
    return [..._episodeList];
  }

}