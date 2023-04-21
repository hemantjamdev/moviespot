import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../model/movie_details_provider.dart';
import '../model/popular_model.dart';

class PopularProvider extends ChangeNotifier {
  PopularProvider() {
    getPopular();
  }

  List<MovieModel> movieModel = <MovieModel>[];

  getPopular() async {
    Map<dynamic, dynamic> res = await API.tmdb.v3.movies.getPopular();
    List<dynamic> list = res["results"];
    for (var element in list) {
      movieModel.add(MovieModel.fromJson(element));
    }
    notifyListeners();
  }
}
