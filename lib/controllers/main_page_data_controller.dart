import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/main_page.dart';
import 'package:movie_app/models/search_category.dart';
import '../models/movie.dart';

import '../services/movie_service.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state])
      : super(state ?? MainPageData.initial()) {
    getMovies();
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie> movies = [];

      if (state.searchText.isEmpty) {
        if (state.searchCategory == SearchCategory.popular) {
          movies = await _movieService.getPopularMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.upcoming) {
          movies = await _movieService.getUpcommingMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.none) {
          movies = [];
        }
      } else {
        movies = await _movieService.searchMOvies(state.searchText,
            page: state.page + 1);
      }

      state = state
          .copyWith([...state.movies, ...movies], state.page + 1, null, null);
    } catch (e) {
      print(e.toString());
    }
  }

  void updateSearchCategory(String category) {
    try {
      state = state.copyWith([], 1, category, '');
      getMovies();
    } catch (e) {
      print(e);
    }
  }

  void updateTextSearch(String _searchText) {
    try {
      state = state.copyWith([], 1, SearchCategory.none, _searchText);
      getMovies();
    } catch (e) {
      print(e);
    }
  }
}
