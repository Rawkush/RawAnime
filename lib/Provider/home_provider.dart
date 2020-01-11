import 'package:flutter/cupertino.dart';
import 'package:myapp/Model/latest_episode.dart';
import 'package:myapp/Model/popular_anime.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomeProvider with ChangeNotifier {

  int currentPageLatestEpisodes=1, currentPagePopularAnimes=1, lastPageLatestEpisodes, lastPagePopularAnimes;

  List<LatestEpisode> _latestEpisodes = [
  ];

  List<PopularAnime> _popularAnimes = [
  ];

  List<LatestEpisode> get latestEpisodes{
    return [..._latestEpisodes];
  }

  List<PopularAnime> get popularAnimes{
    return [..._popularAnimes];
  }

  Future<void> fetchLatestEpisodes(int prevOrNext) async {
    var url = 'https://animeflix.io/api/episodes/latest?limit=20&page=${currentPageLatestEpisodes+prevOrNext}';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      var data = json.decode(response.body);
      currentPageLatestEpisodes = data["meta"]["current_page"];
      lastPageLatestEpisodes = data["meta"]["last_page"];
      var episodesData = data["data"] as List;
      _latestEpisodes = episodesData.map<LatestEpisode>((json) => LatestEpisode.fromJson(json)).toList();
      notifyListeners();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post' + response.statusCode.toString());
    }
  }

  Future<void> fetchPopularAnimes(int prevOrNext) async {
    var url = 'https://animeflix.io/api/anime/popular?limit=20&page=${currentPagePopularAnimes+prevOrNext}';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      var data = json.decode(response.body);
      currentPagePopularAnimes = data["meta"]["current_page"];
      lastPagePopularAnimes = data["meta"]["last_page"];
      var animesData = data["data"] as List;
      _popularAnimes = animesData.map<PopularAnime>((json) => PopularAnime.fromJson(json)).toList();
      notifyListeners();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post-' + response.statusCode.toString());
    }
  }
}
