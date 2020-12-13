import 'package:flutter/material.dart';
import 'package:myapp/Widgets/latest_episode_card.dart';
import 'package:myapp/Widgets/popular_anime_card.dart';
import 'package:provider/provider.dart';

import '../Provider/home_provider.dart';

enum PopupMenuValue {
  LatestEpisodes,
  PopularAnimes,
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLatest = true;

  Widget _latestAnimeList(HomeProvider _homeProvider) {
    return GridView.builder(
      itemCount: _isLatest
          ? _homeProvider.latestEpisodes.length
          : _homeProvider.popularAnimes.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 2 / 2.78,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _isLatest
            ? LatestEpisodeCard(_homeProvider.latestEpisodes[index])
            : PopularAnimeCard(_homeProvider.popularAnimes[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final _itemsList =
        _isLatest ? _homeProvider.latestEpisodes : _homeProvider.popularAnimes;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: _height,
      width: _width,
      decoration: BoxDecoration(color: Colors.black87),
      child: Column(
        children: <Widget>[
          PopupMenuButton<PopupMenuValue>(
            child: Container(
              height: _height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.filter_list,
                    color: Colors.white,
                    size: 20,
                  ),
                  Text(
                    " Filter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Latest Episodes"),
                value: PopupMenuValue.LatestEpisodes,
              ),
              PopupMenuItem(
                child: Text("Popular Animes"),
                value: PopupMenuValue.PopularAnimes,
              ),
            ],
            onSelected: (selectedValue) {
              if ((_isLatest &&
                      selectedValue == PopupMenuValue.LatestEpisodes) ||
                  (!_isLatest && selectedValue == PopupMenuValue.PopularAnimes))
                return;
              setState(() {
                _isLatest = !_isLatest;
              });
            },
          ),
          Expanded(
            child: _itemsList.isEmpty
                ? FutureBuilder(
                    future: _isLatest
                        ? _homeProvider.fetchLatestEpisodes(0)
                        : _homeProvider.fetchPopularAnimes(0),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      if (snapshot.error != null)
                        return Center(
                          child: Text("An error occurred", style: TextStyle(color: Colors.white),),
                        );
                      return _latestAnimeList(_homeProvider);
                    },
                  )
                : _latestAnimeList(_homeProvider),
          ),
        ],
      ),
    );
  }
}
