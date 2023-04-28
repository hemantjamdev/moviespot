import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../model/movie_model.dart';

class RecommendedProvider extends ChangeNotifier {

  List<MoviesListModel> movieModel = <MoviesListModel>[];

 void recommended(BuildContext context,int movieId) async {
    movieModel = await API.getRecommended(context,movieId);
    notifyListeners();
  }
}
