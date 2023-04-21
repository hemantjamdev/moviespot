import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/model/popular_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({super.key});

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  TMDB tmdb = TMDB(ApiKeys(Strings.apiKeyV3, Strings.apiReadAccessTokenv4),
      logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
          showUrlLogs: true,
          showInfoLogs: true,
          showWarningLogs: true));
  PopularModel popularModel = PopularModel();

  getPopular() async {
    Map<dynamic, dynamic> res = await tmdb.v3.movies.getPopular();
    popularModel = PopularModel.fromJson(res as Map<String, dynamic>);
    setState(() {});
  }

  @override
  void initState() {
    getPopular();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 700,
      child: popularModel.results != null
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: popularModel.results!.length,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                      "${Strings.imageBase}${popularModel.results![index].posterPath}"),
                );
              })
          : const SizedBox(),
    );
  }
}
