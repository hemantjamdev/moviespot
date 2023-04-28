import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../constants/strings.dart';
import '../model/movie_model.dart';

class RecommendedProvider extends ChangeNotifier {
 /* RecommendedProvider() {
    recommended();
  }*/

  List<MoviesListModel> movieModel = <MoviesListModel>[];

  recommended(int movieId) async {
    movieModel = await API.getRecommended(movieId);
    notifyListeners();
  }
}
