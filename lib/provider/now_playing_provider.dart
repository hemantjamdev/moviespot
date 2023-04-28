import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';
import 'package:moviespot/constants/strings.dart';

import '../model/movie_model.dart';

class NowPlayingProvider extends ChangeNotifier {
  int index = 0;

  void changeIndex(int number) {
    index = number;
    notifyListeners();
  }

  NowPlayingProvider(BuildContext context) {
    getNowPlaying(context);
  }

  List<MoviesListModel> movieModel = <MoviesListModel>[];

  void getNowPlaying(BuildContext context) async {
    movieModel = await API.getMovieList(context, Strings.nowPlaying);
    notifyListeners();
  }
}
