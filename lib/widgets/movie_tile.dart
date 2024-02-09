import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/movie.dart';

class MovieTile extends StatelessWidget {
  final double height;
  final double width;
  final Movie movie;
  final GetIt _getIt = GetIt.instance;
  MovieTile({required this.movie, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _moviePosterWidget(movie.posterUrl()),
        _movieInfosWidget(),
      ],
    );
  }

  Widget _moviePosterWidget(String _imageUrl) {
    return Container(
      height: height,
      width: width * 0.35,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(_imageUrl),
          ),
          borderRadius: BorderRadius.circular(1)),
    );
  }

  Widget _movieInfosWidget() {
    return Container(
      height: height,
      width: width * 0.75,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.60,
                child: Text(
                  movie.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                movie.rating.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
            child: Text(
              '${movie.language.toUpperCase()} | R: ${(movie.isAdul)} | ${movie.releasedDate}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.75,
            height: height * 0.65,
            //padding: EdgeInsets.fromLTRB(0, height * 0.07, 0, 0),
            child: Text(
              movie.desciption,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
              ),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
