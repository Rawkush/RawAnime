/*this file contains all mapping json to class object for different queries*/

/*
recently updated
*/
class Updated_Anime {
  final String episode;
  final String img;
  final String url;
  final String title;

  Updated_Anime({this.episode, this.img, this.url, this.title});

  factory Updated_Anime.fromJson(Map<String, dynamic> json) {
    return Updated_Anime(
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

class Anime_Content {
  final String episode;
  final String img;
  final String url;
  final String title;
  final String genre;
  final String summary;
  final String type;
  final String status;
  final String other_name;
  final String released;

  Anime_Content({
      this.genre,
      this.summary,
      this.type,
      this.status,
      this.other_name,
      this.released,
      this.episode,
      this.img,
      this.url,
      this.title});

  factory Anime_Content.fromJson(Map<String, dynamic> json) {
    return Anime_Content(
      episode: json['episode'],
      img: json['img'],
      title: json['title'],
      url: json['base_url'],
      type: json['others']['Type'],
      status: json['others']['Status']
      
    );
  }
}
