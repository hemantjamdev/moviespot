import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../constants/strings.dart';
import '../model/movie_model.dart';

class TopRatedProvider extends ChangeNotifier {
  TopRatedProvider(BuildContext context) {
    getTopRatesMovie(context);
  }

  List<MoviesListModel> movieModel = <MoviesListModel>[];

  void getTopRatesMovie(BuildContext context) async {
    movieModel = await API.getMovieList(context,Strings.topRated);
    notifyListeners();
  }
}
