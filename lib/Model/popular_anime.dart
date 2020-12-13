class PopularAnime{
  final int id;
  final rating;
  final String title, slug, image;
  PopularAnime({this.id, this.rating, this.title, this.slug, this.image});

  factory PopularAnime.fromJson(Map<String,dynamic> json){
    return PopularAnime(
      id: json["id"],
      title: json["title"],
      image: json["cover_photo"],
      slug: json["slug"],
      rating: json["gwa_rating"],
    );
  }
}