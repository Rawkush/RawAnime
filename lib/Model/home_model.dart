import 'package:myapp/Model/episode_model.dart';

class HomeModel {
  final String id, title, image;
  final List<Episode> episodes;
  HomeModel({this.id, this.title, this.image, this.episodes});
}