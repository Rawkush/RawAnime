class LatestEpisode{
  final int id, episodeId;
  final String title, type, image, slug, episodeNumber;
  LatestEpisode({this.id, this.episodeId, this.title, this.image, this.type, this.slug, this.episodeNumber});

  factory LatestEpisode.fromJson(Map<String,dynamic> json){
    return LatestEpisode(
      id: json["id"],
      title: json["title"],
      episodeId: json["episode"]["id"],
      episodeNumber: json["episode_num"],
      image: json["thumbnail"],
      slug: json["anime"]["slug"],
      type: json["type"],
    );
  }
}