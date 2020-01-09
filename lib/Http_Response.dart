/*this file contains all mapping json to class object for different queries*/

/*
recently updated
*/
class LatestAnime {
  final String episode;
  final String img;
  final String url;
  final String title;

  LatestAnime({this.episode, this.img, this.url, this.title});

  factory LatestAnime.fromJson(Map<String, dynamic> json) {
    return LatestAnime(
      episode: json['episode'],
      img: json['img'],
      title: json['title'],
      url: json['url'],
    );
  }
}

/*
  Anime Content
*/

class AnimeContent {
  final String episode;
  final String img;
  final String url;
  final String title;
  final String genre;
  final String summary;
  final String type;
  final String status;
  final String otherName;
  final String released;

  AnimeContent({
      this.genre,
      this.summary,
      this.type,
      this.status,
      this.otherName,
      this.released,
      this.episode,
      this.img,
      this.url,
      this.title});

  factory AnimeContent.fromJson(Map<String, dynamic> json) {
    return AnimeContent(
      episode: json['episode'],
      img: json['img'],
      title: json['title'],
      url: json['base_url'],
      type: json['others']['Type'],
      status: json['others']['Status'],
    );
  }
}
