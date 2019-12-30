
/* https request */
import 'Http_Response.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


Future<List<Updated_Anime>> fetch_Updated_Animes() async {
  List<Updated_Anime> list;
  var url = 'https://rawanime.herokuapp.com/';
  var data = {'intent': 'new'};
  final response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: json.encode(data));
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    var data = json.decode(response.body);
    var rest = data["data"] as List;
    list = rest.map<Updated_Anime>((json) => Updated_Anime.fromJson(json)).toList();
    return list;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post' + response.statusCode.toString());
  }
}
