import 'package:flutter/cupertino.dart';
import 'package:myapp/Model/home_model.dart';
import '../Http_Response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomeProvider with ChangeNotifier {
  List<LatestAnime> _latestAnime = [
  ];

  List<LatestAnime> get latestAnime {
    return [..._latestAnime];
  }

  List<HomeModel> _itemsToShow = [
  ];

  List<HomeModel> get itemsToShow {
    return [..._itemsToShow];
  }

  /* void search(String value) {
    _itemsToShow.clear();
    if (value == null)
      _itemsToShow.addAll(_latestAnime);
    else if (value.isEmpty)
      _itemsToShow.addAll(_latestAnime);
    else {
      _latestAnime.forEach((item) {
        if (item.title.toLowerCase().contains(value.toLowerCase()))
          _itemsToShow.add(item);
      });
    }
    notifyListeners();
  } */

  /* LatestAnime getElementWithId(String id) {
    return _latestAnime[_latestAnime.indexWhere((element) {
      return element.id == id;
    })];
  } */

  Future<void> fetchLatestAnimes() async {
    var url = 'https://rawanime.herokuapp.com/';
    var data = {'intent': 'new'};
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      var data = json.decode(response.body);
      var rest = data["data"] as List;
      _latestAnime = rest.map<LatestAnime>((json) => LatestAnime.fromJson(json)).toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post' + response.statusCode.toString());
    }
  }
}
