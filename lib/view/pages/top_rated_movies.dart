import 'package:flutter/material.dart';
import 'package:moviespot/model/movie_details_provider.dart';
import 'package:moviespot/provider/top_rated_provider.dart';
import 'package:moviespot/view/widgets/poster.dart';
import 'package:provider/provider.dart';

class TopRated extends StatelessWidget {
  const TopRated({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TopRatedProvider>(
      builder: (context, TopRatedProvider provider, child) {
        return SizedBox(
          height: 300,
          child: provider.movieModel != null
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.movieModel.length,
                  itemBuilder: (context, int index) {
                    MovieModel movie = provider.movieModel[index];
                    return Poster(
                      movie: movie,
                    );
                  },
                )
              : const SizedBox(),
        );
      },
    );
  }
}
