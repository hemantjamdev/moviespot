import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../constants/strings.dart';
import '../model/movie_model.dart';

class PopularProvider extends ChangeNotifier {
  PopularProvider(BuildContext context) {
    getPopular(context);
  }

  List<MoviesListModel> movieModel = <MoviesListModel>[];

 void getPopular(BuildContext context) async {
    movieModel = await API.getMovieList(context,Strings.popular);
    notifyListeners();
  }
}
