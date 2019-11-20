import 'package:flutter/material.dart';
import 'Http_Requests.dart';
import 'Http_Response.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Updated_Anime>> recent_anime_list;

  @override
  void initState() {
    super.initState();
    recent_anime_list = fetch_Updated_Animes();
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
          child: FutureBuilder<List<Updated_Anime>>(
            future: recent_anime_list,
            builder: (context, snapshot) {
              return displayView(snapshot);
            },
          ),
        ),
      ),
    );
  }
}

Widget displayView(var snapshot) {
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
}

//UI Components below
Card animeCard(Update_Anime data) {
  final animeCard = Card(
    elevation: 8.0,
    child: Row(
      children: <Widget>[
        Container(
          height: 200,
          width: 200,
          color: Colors.red,
          child: Image.network(
            data.img.toString(),
          ),
        ),
        Container(
          height: 200,
          color: Colors.red,
          child: Column(
            children: <Widget>[
             Flexible( child: Text(data.title.toString())),
             Text(data.episode.toString()),
            ],
          ),
        ),
        //   Image.network(
        //     data.img.toString(),
        //   ),
        //   Text(data.title.toString()),
        //   Text(data.episode.toString()),
        //
      ],
    ),
  );
  return animeCard;
}
