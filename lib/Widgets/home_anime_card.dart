import 'package:flutter/material.dart';
import 'package:myapp/Http_Response.dart';

class HomeAnimeCard extends StatelessWidget {
  final LatestAnime _latestAnime;
  HomeAnimeCard(this._latestAnime);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Navigator.of(context).pushNamed('/detailPage',arguments: _latestAnime.url);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox.expand(
                child: Image.network(
                  _latestAnime.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: MediaQuery.of(context).size.shortestSide * 0.4,
                color: Colors.black54,
                child: Center(
                  child: Text(
                    _latestAnime.title.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(color: Colors.white),
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
