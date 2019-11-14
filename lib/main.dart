import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/* https request */
Future<List<Post>> fetchPost() async {
  List<Post> list;
  var url = 'https://rawanime.herokuapp.com/';
  var data = {'intent': 'new'};
  final response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: json.encode(data));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    var data = json.decode(response.body);
    var rest = data["data"] as List;
    list = rest.map<Post>((json) => Post.fromJson(json)).toList();
    return list;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post' + response.statusCode.toString());
  }
}

/*mapping json to class object*/
class Post {
  final String episode;
  final String img;
  final String url;
  final String title;

  Post({this.episode, this.img, this.url, this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      episode: json['episode'],
      img: json['img'],
      title: json['title'],
      url: json['url'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Post>> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Post>>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return animeCard(snapshot.data[index]);
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

//UI Components below
Card animeCard(Post data) {
  final animeCard = Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: Column(
        children: <Widget>[
          Image.network(
            data.img.toString(),
          ),
          Text(data.title.toString()),
          Text(data.episode.toString()),
        ],
      ),
    ),
  );
  return animeCard;
}
