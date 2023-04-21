import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/model/now_playing_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  NowPlayingModel nowPlayingModel = NowPlayingModel();

  TMDB tmdb = TMDB(ApiKeys(Strings.apiKeyV3, Strings.apiReadAccessTokenv4),
      logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
          showUrlLogs: true,
          showInfoLogs: true,
          showWarningLogs: true));

  getNowPlaying() async {
    Map<dynamic, dynamic> res = await tmdb.v3.movies.getNowPlaying();
    nowPlayingModel = NowPlayingModel.fromJson(res as Map<String, dynamic>);
    setState(() {});
  }

  @override
  void initState() {
    getNowPlaying();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 700,
      child: nowPlayingModel.results != null
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: nowPlayingModel.results!.length,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                      "${Strings.imageBase}${nowPlayingModel.results![index].posterPath}"),
                );
              })
          : const SizedBox(),
    );
  }
}
