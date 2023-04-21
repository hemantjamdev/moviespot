import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/model/movie_details_provider.dart';
import 'package:moviespot/model/popular_model.dart';
import 'package:moviespot/provider/popular_provider.dart';
import 'package:moviespot/view/widgets/poster.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

//import '../../model/now_playing_model.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PopularProvider>(
        builder: (context, PopularProvider provider, child) {
      return SizedBox(
        height: 300,
        width: 700,
        child: provider.movieModel.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: provider.movieModel.length,
                itemBuilder: (context, int index) {
                  MovieModel movie = provider.movieModel[index];
                  return Poster(
                    movie: movie,
                  );
                })
            : const SizedBox(),
      );
    });
  }
}
