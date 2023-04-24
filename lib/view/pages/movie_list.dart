import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/view/pages/now_playing.dart';
import 'package:moviespot/view/pages/popular_movies.dart';
import 'package:moviespot/view/pages/top_rated_movies.dart';
import 'package:provider/provider.dart';

import '../../utils/inernet_connectivity.dart';
import 'movie_list.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Now Showing",
                style: TextStyle(fontSize: 24),
              ),
              NowPlaying(),
              const Text(
                "Top Rated",
                style: TextStyle(fontSize: 24),
              ),
              const TopRated(),
              const Text(
                "Popular",
                style: TextStyle(fontSize: 24),
              ),
              const PopularMovies(),
            ],
          ),
        ),
      ),
    );
  }
}
