import 'package:flutter/material.dart';
import 'package:moviespot/provider/top_rated_provider.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../constants/strings.dart';
import '../../model/top_rated_model.dart';

class TopRated extends StatelessWidget {
  const TopRated({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TopRatedProvider>(
        builder: (context, TopRatedProvider provider, child) {
      return SizedBox(
        height: 300,
        child: provider.topRatedModel.results != null
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: provider.topRatedModel.results!.length,
                itemBuilder: (context, int index) {
                  return Image.network(
                    "${Strings.imageBase}${provider.topRatedModel.results![index].posterPath}",
                  );
                })
            : const SizedBox(),
      );
    });
  }
}
