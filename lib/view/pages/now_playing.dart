import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/model/now_playing_model.dart';
import 'package:moviespot/view/pages/movie_details.dart';
import 'package:moviespot/view/widgets/poster.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../model/movie_details_provider.dart';
import '../../provider/now_playing_provider.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NowPlayingProvider>(
      builder: (context, NowPlayingProvider provider, child) {
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
                      // heroTag: index.toString(),
                    );
                  },
                )
              : const SizedBox(),
        );
      },
    );
  }
}
