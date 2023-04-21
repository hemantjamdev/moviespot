import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../constants/strings.dart';
import '../model/movie_details_model.dart';

class TopRatedProvider extends ChangeNotifier {
  TopRatedProvider() {
    getTopRatesMovie();
  }

  List<MovieModel> movieModel = <MovieModel>[];

  getTopRatesMovie() async {
    movieModel = await API.getMovieList(Strings.topRated);
    notifyListeners();
  }
}
