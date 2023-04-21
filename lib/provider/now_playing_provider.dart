import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';
import 'package:moviespot/constants/strings.dart';

import '../model/movie_details_model.dart';

class NowPlayingProvider extends ChangeNotifier {
  NowPlayingProvider() {
    getNowPlaying();
  }

  List<MovieModel> movieModel = <MovieModel>[];

  getNowPlaying() async {
    movieModel = await API.getMovieList(Strings.nowPlaying);
    notifyListeners();
  }
}
