import 'package:flutter/material.dart';
import 'package:moviespot/constants/colors.dart';
import 'package:moviespot/model/movie_model.dart';
import 'package:moviespot/view/pages/movie_details.dart';
import 'package:sizer/sizer.dart';

import '../../constants/strings.dart';

Widget movieCardList(BuildContext context, List<MoviesListModel> movies) {
  return AnimatedList(
    itemBuilder:
        (BuildContext context, int index, Animation<double> animation) {
      return _buildAnimatedListItem(context, movies[index], animation);
    },
    initialItemCount: movies.length,
  );
}

Widget _buildAnimatedListItem(
    BuildContext context, MoviesListModel item, Animation<double> animation) {
  return SizeTransition(
      sizeFactor: animation, child: movieDetailsCard(context, item));
}

Widget movieDetailsCard(BuildContext context, MoviesListModel movie) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetails(
            movieId: movie.id!,
                     ),
        ),
      );
    },
    child: Card(
      elevation: 5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30.h,
            width: 50.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      Strings.imageBase + movie.posterPath.toString()),
                  fit: BoxFit.cover),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40.w,
                  child: Text(
                    movie.title.toString(),
                    maxLines: 2,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color:AppColors.amber),
                    const SizedBox(width: 4),
                    Text(
                      movie.voteAverage.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text(
                  movie.releaseDate.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 40.w,
                  child: Text(
                    movie.overview.toString(),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
