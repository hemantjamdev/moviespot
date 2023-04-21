import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/model/PopularModel.dart';
import 'package:moviespot/model/TopRatedModel.dart';
import 'package:moviespot/model/NowPlayingModel.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TopRatedModel topRatedModel = TopRatedModel();
  NowPlayingModel nowPlayingModel = NowPlayingModel();
  PopularModel popularModel = PopularModel();

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

  getNowPlaying() async {
    Map<dynamic, dynamic> res = await tmdb.v3.movies.getNowPlaying();
    nowPlayingModel = NowPlayingModel.fromJson(res as Map<String, dynamic>);
    setState(() {});
  }

  getPopular() async {
    Map<dynamic, dynamic> res = await tmdb.v3.movies.getPopular();
    popularModel = PopularModel.fromJson(res as Map<String, dynamic>);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Title")),
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: getTopRatesMovie,
                    child: const Text("getLatestMovie")),
                SizedBox(
                  height: 300,
                  child: topRatedModel.results!=null
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
                ),
                OutlinedButton(
                    onPressed: getNowPlaying, child: const Text("getNowPlaying")),
                SizedBox(
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
                ),
                OutlinedButton(
                    onPressed: getPopular, child: const Text("getPopular")),
                SizedBox(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
