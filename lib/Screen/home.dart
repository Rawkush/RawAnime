import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/home_provider.dart';
import '../Widgets/home_anime_card.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final _homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: _height,
        width: _width,
        decoration: BoxDecoration(color: Colors.black87),
        child: GridView.builder(
          itemCount: _homeProvider.homeList.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 190,
            childAspectRatio: 2 / 2.78,
            mainAxisSpacing: 11,
            crossAxisSpacing: 11,
          ),
          itemBuilder: (BuildContext context, int index) {
            return HomeAnimeCard(_homeProvider.homeList[index]);
          },
        ),
      ),
    );
  }
}
