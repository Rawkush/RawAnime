class SearchAnime{
  final int id;
  final String title, slug, description, image;
  final double rating;

  SearchAnime({this.id, this.title, this.slug, this.description, this.image, this.rating});

  factory SearchAnime.fromJson(Map<String,dynamic> json){
    return SearchAnime(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      description: json["description"],
      image: json["cover_photo"],
      rating: json["gwa_rating"],
    );
  }
}