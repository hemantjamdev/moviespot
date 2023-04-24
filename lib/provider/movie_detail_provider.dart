import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:moviespot/model/cast_model.dart';

import '../constants/api.dart';
import '../model/movie_detail_model.dart';
import '../model/screen_shot_model.dart';

class MovieDetailsProvider extends ChangeNotifier {
  CastModel castModel = CastModel();
  ScreenShotModel screenShotModel = ScreenShotModel();
  List<Cast> casts = <Cast>[];
  List<Crew> crew = <Crew>[];
  MovieDetailsModel movieDetailsModel = MovieDetailsModel();

  getMovieDetail(int movieId) async {
    final res = await API.getMovieDetails(movieId);
    return movieDetailsModel =
        MovieDetailsModel.fromJson(res as Map<String, dynamic>);
  }

  getCasting(int movieId) async {
    casts.clear();
    crew.clear();
    castModel = await API.getCasting(movieId);
    getCrew(castModel);
    for (var element in castModel.cast!) {
      casts.add(element);
    }
    notifyListeners();
  }

  getCrew(CastModel castModel) {
    for (var element in castModel.crew!) {
      crew.add(element);
    }
    notifyListeners();
  }

  getImages(int movieId) async {
    final res = await API.getMovieImages(movieId);
    screenShotModel = ScreenShotModel.fromJson(res as Map<String, dynamic>);
    notifyListeners();
  }

/*@override
  void dispose() {
    castModel.crew?.clear();
    castModel.cast?.clear();
    log("dispose caleeddddd");
    super.dispose();
  }*/
}
