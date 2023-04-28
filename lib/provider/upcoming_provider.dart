import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../constants/strings.dart';
import '../model/movie_model.dart';

class UpComingProvider extends ChangeNotifier {
  UpComingProvider() {
    getUpComingMovie();
  }

  List<MoviesListModel> movieModel = <MoviesListModel>[];

  getUpComingMovie() async {
    movieModel = await API.getMovieList(Strings.upComing);
    notifyListeners();
  }
}
