import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/services/http_service.dart';

import '../models/movie.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;
  late HTTPService _http;

  MovieService() {
    _http = getIt.get<HTTPService>();
  }

  Future<List<Movie>> getPopularMovies({required int page}) async {
    Response _response =
        await _http.get('/movie/popular', query: {'page': page});

    if (_response.statusCode == 200) {
      Map _data = _response.data;

      List<Movie> _movies = await _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();

      return _movies;
    } else {
      throw Exception('Couldn\'t load popular movies');
    }
  }

  Future<List<Movie>> getUpcommingMovies({required int page}) async {
    Response _response =
        await _http.get('/movie/upcoming', query: {'page': page});

    if (_response.statusCode == 200) {
      Map _data = _response.data;

      List<Movie> _movies = await _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();

      return _movies;
    } else {
      throw Exception('Couldn\'t load upcomming movies');
    }
  }

  Future<List<Movie>> searchMOvies(String _searchItem,
      {required int page}) async {
    Response _response = await _http
        .get('/search/movie', query: {'query': _searchItem, 'page': page});

    if (_response.statusCode == 200) {
      Map _data = _response.data;

      List<Movie> _movies = await _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();

      return _movies;
    } else {
      throw Exception('Couldn\'t load perfom  movies search');
    }
  }
}
