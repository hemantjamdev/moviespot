import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../constants/strings.dart';
import '../model/movie_model.dart';

class PopularProvider extends ChangeNotifier {
  PopularProvider() {
    getPopular();
  }

  List<MoviesListModel> movieModel = <MoviesListModel>[];

  getPopular() async {
    movieModel = await API.getMovieList(Strings.popular);
    notifyListeners();
  }
}
