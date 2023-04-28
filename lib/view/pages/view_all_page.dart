import 'package:flutter/material.dart';
import 'package:moviespot/view/widgets/poster.dart';

import '../../model/movie_model.dart';

class ViewAll extends StatelessWidget {
  final List<MoviesListModel> movies;
  final String title;

  const ViewAll({Key? key, required this.movies, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GridView.builder(
          itemCount: movies.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, int index) {
            MoviesListModel movie = movies[index];
            return Poster(movie: movie);
          }),
    );
  }
}
