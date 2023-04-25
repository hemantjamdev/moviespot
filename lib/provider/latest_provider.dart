/*
import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../constants/strings.dart';
import '../model/movie_model.dart';

class LatestProvider extends ChangeNotifier {
  LatestProvider() {
    getLatest();
  }

  List<MovieModel> movieModel = <MovieModel>[];

  getLatest() async {
    movieModel = await API.getMovieList(Strings.latest);
    notifyListeners();
  }
}
*/
