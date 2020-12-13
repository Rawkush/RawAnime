import 'package:flutter/material.dart';
import 'package:myapp/Model/search_model.dart';

class SearchAnimeCard extends StatelessWidget {
  final SearchAnime _searchAnime;
  SearchAnimeCard(this._searchAnime);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Container(
      height: _height * 0.25,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: SizedBox(
                height: _height * 0.25,
                width: _width,
                child: Image.network(
                  _searchAnime.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                width: _width * 0.7,
                color: Colors.black54,
                child: Text(
                  _searchAnime.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
