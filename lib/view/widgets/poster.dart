import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/model/movie_details_provider.dart';
import 'package:moviespot/model/now_playing_model.dart';
import 'package:moviespot/view/pages/movie_details.dart';

class Poster extends StatelessWidget {
  final MovieModel movie;
  final Key heroKey;

//final BuildContext myContext;
  Poster({Key? key, required this.movie})
      : heroKey = UniqueKey(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetails(
                        movie: movie,
                        heroTag: heroKey,
                      )));
        },
        child: SizedBox(
          height: 250,
          width: 250,
          child: Card(
            elevation: 10,
            child: Hero(
              tag: heroKey,
              child: Image.network(
                Strings.imageBase + movie.posterPath.toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
