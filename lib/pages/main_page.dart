import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/controllers/main_page_data_controller.dart';
import 'package:movie_app/models/main_page.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/movie_tile.dart';
import '../models/search_category.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>(
        (ref) => MainPageDataController());
final selectedMoviePosterUrlProvider = StateProvider<String?>((ref) {
  final movies = ref.watch(mainPageDataControllerProvider).movies;
  return movies.length != 0 ? movies[0].posterUrl() : null;
});

class MainPage extends ConsumerWidget {
  late double _deviceHeight;
  late double _deviceWidth;

  late var selectedMoviePosterUrl;
  late MainPageDataController _mainPageDataController;
  late MainPageData _mainPageData;

  late TextEditingController _searchTextFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    _mainPageDataController =
        ref.watch(mainPageDataControllerProvider.notifier);
    _mainPageData = ref.watch(mainPageDataControllerProvider);

    selectedMoviePosterUrl = ref.watch(selectedMoviePosterUrlProvider.state);
    _searchTextFieldController = TextEditingController();

    _searchTextFieldController.text = _mainPageData.searchText;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(),
            _foregroundWidget(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
        height: _deviceHeight,
        width: _deviceWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://sm.ign.com/ign_fr/movie/w/wonder-wom/wonder-woman-live-action_m1ef.jpg'),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        ));
  }

  Widget _foregroundWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _deviceHeight * 0.01, 0, 0),
      width: _deviceWidth * 0.95,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(),
          Container(
            alignment: Alignment.center,
            height: _deviceHeight * 0.83,
            padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.01),
            child: _movieListViewWidget(),
          )
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      margin: EdgeInsets.only(
          left: _deviceHeight * 0.01, right: _deviceHeight * 0.01),
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_searchFileWidget(), _categorySelectionWidget()]),
    );
  }

  Widget _searchFileWidget() {
    final _border = InputBorder.none;
    return Container(
      width: _deviceWidth * 0.50,
      height: _deviceHeight * 0.05,
      child: TextField(
        controller: _searchTextFieldController,
        onSubmitted: (_input) =>
            _mainPageDataController.updateTextSearch(_input),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            focusedBorder: _border,
            border: _border,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white54,
            ),
            hintStyle: const TextStyle(
              color: Colors.white54,
            ),
            filled: false,
            fillColor: Colors.white54,
            hintText: "Search....."),
      ),
    );
  }

  Widget _categorySelectionWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: _mainPageData.searchCategory,
      icon: const Icon(
        Icons.menu,
        color: Colors.white54,
      ),
      underline: Container(
        height: 1,
        color: Colors.white54,
      ),
      onChanged: (_value) => _value.toString().isNotEmpty
          ? _mainPageDataController.updateSearchCategory(_value.toString())
          : null,
      items: [
        DropdownMenuItem(
            value: SearchCategory.popular,
            child: Text(
              SearchCategory.popular,
              style: const TextStyle(
                color: Colors.white54,
              ),
            )),
        DropdownMenuItem(
            value: SearchCategory.upcoming,
            child: Text(
              SearchCategory.upcoming,
              style: const TextStyle(
                color: Colors.white54,
              ),
            )),
        DropdownMenuItem(
            value: SearchCategory.none,
            child: Text(
              SearchCategory.none,
              style: const TextStyle(
                color: Colors.white54,
              ),
            ))
      ],
    );
  }

  Widget _movieListViewWidget() {
    List<Movie> movies = _mainPageData.movies;
    if (movies.isNotEmpty) {
      return NotificationListener(
          onNotification: (onScrollNotification) {
            if (onScrollNotification is ScrollEndNotification) {
              final before = onScrollNotification.metrics.extentBefore;
              final max = onScrollNotification.metrics.maxScrollExtent;
              if (before == max) {
                _mainPageDataController.getMovies();
                return true;
              }
              return false;
            }
            return false;
          },
          child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (BuildContext _context, int _count) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: _deviceHeight * 0.01, horizontal: 0),
                  child: GestureDetector(
                    onTap: () {},
                    child: MovieTile(
                        movie: movies[_count],
                        height: _deviceHeight * 0.20,
                        width: _deviceWidth * 0.85),
                  ),
                );
              }));
    } else {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}
