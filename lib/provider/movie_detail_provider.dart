import 'package:flutter/cupertino.dart';
import 'package:moviespot/model/cast_model.dart';

import '../constants/api.dart';

class MovieDetailsProvider extends ChangeNotifier {
  CastModel castModel = CastModel();
  List<Cast> casts = <Cast>[];

  getCasting(int movieId) async {
    castModel = await API.getCasting(movieId);
    for (var element in castModel.cast!) {
      casts.add(element);
    }
    notifyListeners();
  }
  getImages(int movieId) async {
    final res = await API.getMovieImages(movieId);
   /* for (var element in castModel.cast!) {
      casts.add(element);
    }*/
    notifyListeners();
  }
}
