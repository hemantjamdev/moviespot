import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../model/movie_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<MoviesListModel> movieModel = <MoviesListModel>[];

  void getMovieByGenre(BuildContext context, String genre) async {
    movieModel.clear();
    movieModel = await API.getMovieByGenre(context, genre);
    notifyListeners();
  }
}
