import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/home_provider.dart';
import '../Widgets/search_anime_card.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final _searchProvider = Provider.of<HomeProvider>(context);
    return Column(
      children: <Widget>[
        Container(
          height: _height * 0.30,
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: _height * 0.25,
                width: _width,
                child: Image.asset(
                  "assets/images/el.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Text(
                  "Hey there! Bored?\nFind your favourite anime below.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Positioned(
                width: _width * 0.9,
                height: _height * 0.08,
                left: _width * 0.05,
                bottom: _height * 0.01,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 5),
                      Icon(Icons.search),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            hintText: "What are you looking for...",
                          ),
                          onChanged: (value) => _searchProvider.search(value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          "Recent",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
              bottom: 5,
            ),
            itemCount: _searchProvider.itemsToShow.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                    print(_searchProvider.itemsToShow[index].id);
                    Navigator.of(context).pushNamed('/detailPage',
                        arguments: _searchProvider.itemsToShow[index].id);
                  },
                  child: SearchAnimeCard(_searchProvider.itemsToShow[index]));
            },
          ),
        ),
      ],
    );
  }
}
