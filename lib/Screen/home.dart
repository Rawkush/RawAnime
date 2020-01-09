import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/home_provider.dart';
import '../Widgets/home_anime_card.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  Widget _latestAnimeList(HomeProvider _homeProvider) {
    return GridView.builder(
      itemCount: _homeProvider.latestAnime.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 2 / 2.78,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return HomeAnimeCard(_homeProvider.latestAnime[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: _height,
        width: _width,
        decoration: BoxDecoration(color: Colors.black87),
        child: _homeProvider.latestAnime.isEmpty
            ? FutureBuilder(
                future: _homeProvider.fetchLatestAnimes(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  if (snapshot.error != null)
                    return Center(
                      child: Text("An error occurred"),
                    );
                  return _latestAnimeList(_homeProvider);
                },
              )
            : _latestAnimeList(_homeProvider),
      ),
    );
  }
}
