import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/model/popular_model.dart';
import 'package:moviespot/provider/popular_provider.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PopularProvider>(
        builder: (context, PopularProvider provider, child) {
      return SizedBox(
        height: 300,
        width: 700,
        child: provider.popularModel.results != null
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: provider.popularModel.results!.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                        "${Strings.imageBase}${provider.popularModel.results![index].posterPath}"),
                  );
                })
            : const SizedBox(),
      );
    });
  }
}
