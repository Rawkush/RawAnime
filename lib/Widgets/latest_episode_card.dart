import 'package:flutter/material.dart';
import 'package:myapp/Model/latest_episode.dart';

class LatestEpisodeCard extends StatelessWidget {
  final LatestEpisode _latestEpisode;
  LatestEpisodeCard(this._latestEpisode);

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
                  _latestEpisode.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: Text(
                  "Ep ${_latestEpisode.episodeNumber}",
                  style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold,),
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
                    _latestEpisode.title.toString(),
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
