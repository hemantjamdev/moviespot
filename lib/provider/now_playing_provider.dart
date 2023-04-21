import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../model/movie_details_provider.dart';
import '../model/now_playing_model.dart';

class NowPlayingProvider extends ChangeNotifier {
  NowPlayingProvider() {
    getNowPlaying();
  }

  // NowPlayingModel nowPlayingModel = NowPlayingModel();
  List<MovieModel> movieModel = <MovieModel>[];

  getNowPlaying() async {
    Map<dynamic, dynamic> res = await API.tmdb.v3.movies.getNowPlaying();
    List<dynamic> list = res["results"];
    for (var element in list) {
      movieModel.add(MovieModel.fromJson(element));
    }
    notifyListeners();
  }
}
