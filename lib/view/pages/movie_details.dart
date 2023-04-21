import 'package:flutter/material.dart';
import 'package:moviespot/model/movie_details_provider.dart';

import '../../constants/strings.dart';

class MovieDetails extends StatelessWidget {
  final MovieModel movie;
  final Key heroTag;

  const MovieDetails({Key? key, required this.movie, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title.toString())),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: heroTag,
                child: Image.network(
                  Strings.imageBase + movie.posterPath.toString(),
                ),
              ),
              Text(movie.popularity.toString()),
              Text(movie.releaseDate.toString()),
              Text(movie.voteAverage.toString()),
              Text(movie.voteCount.toString()),
              Text(movie.overview.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
