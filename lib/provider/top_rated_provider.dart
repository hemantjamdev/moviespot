import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../model/movie_details_provider.dart';
import '../model/top_rated_model.dart';

class TopRatedProvider extends ChangeNotifier {
  TopRatedProvider() {
    getTopRatesMovie();
  }

  // TopRatedModel topRatedModel = TopRatedModel();
  List<MovieModel> movieModel = <MovieModel>[];

  getTopRatesMovie() async {
    Map<dynamic, dynamic> res = await API.tmdb.v3.movies.getTopRated();
    List<dynamic> list = res["results"];
    for (var element in list) {
      movieModel.add(MovieModel.fromJson(element));
    }
    notifyListeners();
  }
}
