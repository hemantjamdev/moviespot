import 'package:flutter/material.dart';
import 'package:moviespot/model/movie_model.dart';
import 'package:moviespot/view/widgets/poster.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/recommended_provider.dart';
import '../widgets/loading.dart';

class Recommended extends StatelessWidget {
  final int movieId;

  const Recommended({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    Provider.of<RecommendedProvider>(context, listen: false)
        .recommended(context,movieId);
    return Consumer<RecommendedProvider>(
      builder: (context, RecommendedProvider provider, child) {
        return SizedBox(
          height: 40.h,
          child: provider.movieModel.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, int index) {
                    MoviesListModel movie = provider.movieModel[index];
                    return Poster(movie: movie);
                  })
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.movieModel.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: shimmer(height: 30.h, width: 50.w),
                    );
                  },
                ),
        );
      },
    );
  }
}
