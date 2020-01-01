import 'package:flutter/cupertino.dart';
import 'package:myapp/Model/home_model.dart';

class HomeProvider with ChangeNotifier {
  List<HomeModel> _homeList = [
    HomeModel(
        id: '1',
        title: "title",
        img:
            "https://images.unsplash.com/photo-1577401749907-4613bde19b2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
    HomeModel(
        id: "2",
        title:
            "title thhgfhgv gkhghj hgljhhghj ljghljh hgljghjjh  fhjgkh jhghbkj jk",
        img:
            "https://images.unsplash.com/photo-1575540325855-4b5d285a3845?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
    HomeModel(
        id: "3",
        title: "title",
        img:
            "https://images.unsplash.com/photo-1571757767119-68b8dbed8c97?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
    HomeModel(
        id: "4",
        title: "title",
        img:
            "https://images.unsplash.com/photo-1541562232579-512a21360020?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"),
  ];

  List<HomeModel> get homeList {
    return [..._homeList];
  }
  HomeModel getElementWithId(String id){
    return _homeList[_homeList.indexWhere((element){return element.id==id;})];
  }

}
