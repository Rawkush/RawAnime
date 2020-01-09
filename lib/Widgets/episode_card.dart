import 'package:flutter/material.dart';
import 'package:myapp/Model/episode_model.dart';

class EpisodeCard extends StatelessWidget {
  final Episode _episode;
  final bool _isPlaying;
  EpisodeCard(this._episode, this._isPlaying);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.longestSide;

    return Container(
      height: _height * 0.15,
      color: _isPlaying ? Theme.of(context).primaryColorLight : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Container(
              width: _width * 0.3,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                image: DecorationImage(
                  image: NetworkImage(_episode.thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Episode #${_episode.episodeNumber}"),
                Text("Episode name"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
