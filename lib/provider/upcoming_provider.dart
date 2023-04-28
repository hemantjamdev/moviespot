import 'package:flutter/material.dart';
import 'package:moviespot/constants/api.dart';

import '../constants/strings.dart';
import '../model/movie_model.dart';

class UpComingProvider extends ChangeNotifier {
  UpComingProvider(BuildContext context) {
    getUpComingMovie(context);
  }

  List<MoviesListModel> movieModel = <MoviesListModel>[];

  void getUpComingMovie(BuildContext context) async {
    movieModel = await API.getMovieList(context,Strings.upComing);
    notifyListeners();
  }
}
