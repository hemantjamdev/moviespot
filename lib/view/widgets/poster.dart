import 'package:flutter/material.dart';
import 'package:moviespot/constants/colors.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/model/movie_details_model.dart';
import 'package:moviespot/model/now_playing_model.dart';
import 'package:moviespot/view/pages/movie_details.dart';

class Poster extends StatelessWidget {
  final MovieModel movie;
  final Key heroKey;

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
              builder: (context) =>
                  MovieDetails(movie: movie, heroTag: heroKey),
            ),
          );
        },
        child: Hero(
          tag: heroKey,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: AppColors.black),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(
                    Strings.imageBase + movie.posterPath.toString(),
                  ),
                  fit: BoxFit.cover),
            ),
            height: 250,
            width: 250,
          ),
        ),
      ),
    );
  }
}
