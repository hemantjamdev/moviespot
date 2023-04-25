import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/model/movie_model.dart';
import 'package:moviespot/view/pages/movie_details.dart';
import 'package:moviespot/view/widgets/rating.dart';
import 'package:sizer/sizer.dart';

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
                  MovieDetails(movieId: movie.id!, heroTag: heroKey),
            ),
          );
        },
        child: Hero(tag: heroKey, child: MovieCard(movie: movie)),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      height: 30.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: 50.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        Strings.imageBase + movie.posterPath.toString()),
                    fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: buildRating(rating: movie.voteAverage.toString()),
            ),
          ),
          const SizedBox(height: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50.w,
                child: Text(
                  movie.title.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Text(
                movie.releaseDate.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


}
