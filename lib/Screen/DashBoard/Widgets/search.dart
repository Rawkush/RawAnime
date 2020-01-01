import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myapp/Provider/home_provider.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    final _searchProvider = Provider.of<HomeProvider>(context);
    return Column(
      children: <Widget>[
        Container(
          height: _height * 0.35,
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: _height * 0.30,
                width: _width,
                child: Image.network(
                  _searchProvider.itemsToShow[Random().nextInt(4)].img,
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
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
              bottom: 5,
            ),
            itemCount: _searchProvider.itemsToShow.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 190,
              childAspectRatio: 2 / 2.78,
              mainAxisSpacing: 11,
              crossAxisSpacing: 11,
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  print(_searchProvider.itemsToShow[index].id);
                  Navigator.of(context).pushNamed('/detailPage',
                      arguments: _searchProvider.itemsToShow[index].id);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            child: SizedBox.expand(
                              child: Image.network(
                                _searchProvider.itemsToShow[index].img,
                                fit: BoxFit.fill,
                              ),
                            )),
                      ),
                      Flexible(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            color: Colors.grey,
                            child: Center(
                              child: Text(
                                _searchProvider.itemsToShow[index].title
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
