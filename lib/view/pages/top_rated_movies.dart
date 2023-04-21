import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../constants/strings.dart';
import '../../model/top_rated_model.dart';

class TopRated extends StatefulWidget {
  const TopRated({super.key});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  TopRatedModel topRatedModel = TopRatedModel();

  TMDB tmdb = TMDB(ApiKeys(Strings.apiKeyV3, Strings.apiReadAccessTokenv4),
      logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
          showUrlLogs: true,
          showInfoLogs: true,
          showWarningLogs: true));

  getTopRatesMovie() async {
    Map<dynamic, dynamic> res = await tmdb.v3.movies.getTopRated();
    topRatedModel = TopRatedModel.fromJson(res as Map<String, dynamic>);
    setState(() {});
  }

  @override
  void initState() {
    getTopRatesMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: topRatedModel.results != null
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: topRatedModel.results!.length,
              itemBuilder: (context, int index) {
                return Image.network(
                  "${Strings.imageBase}${topRatedModel.results![index].posterPath}",
                );
              })
          : const SizedBox(),
    );
  }
}
