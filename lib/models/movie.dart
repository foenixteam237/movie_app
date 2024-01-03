import 'package:get_it/get_it.dart';
import '../models/app_config.dart';

class Movie {
  final String name;
  final String language;
  final bool isAdul;
  final String desciption;
  final String posterPath;
  final String backDropPath;
  final num rating;
  final String releasedDate;

  Movie(
      {required this.name,
      required this.language,
      required this.isAdul,
      required this.desciption,
      required this.posterPath,
      required this.backDropPath,
      required this.rating,
      required this.releasedDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        name: json['title'],
        language: json['original_language'],
        isAdul: json['adult'],
        desciption: json['overview'],
        posterPath: json['poster_path'],
        backDropPath: json['backdrop_path'],
        rating: json['vote_average'],
        releasedDate: json['release_date']);
  }

  String posterUrl() {
    final AppConfig _appConfig = GetIt.instance.get<AppConfig>();
    return '${_appConfig.BASE_IMAGE_API_URL}${posterPath}';
  }
}
