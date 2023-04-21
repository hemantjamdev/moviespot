import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../model/top_rated_model.dart';

class TopRatedProvider extends ChangeNotifier {
  TopRatedModel topRatedModel = TopRatedModel();

  getTopRatesMovie() async {
    Map<dynamic, dynamic> res = await API.tmdb.v3.movies.getTopRated();
    topRatedModel = TopRatedModel.fromJson(res as Map<String, dynamic>);
    notifyListeners();
  }
}
