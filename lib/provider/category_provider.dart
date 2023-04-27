
import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../model/movie_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<MovieModel> movieModel = <MovieModel>[];
 // List<String> photoList = [];

  void getMovieByGenre(String genre) async {
    movieModel.clear();
    movieModel = await API.getMovieByGenre(genre);
    notifyListeners();
  }

 /* void getPhotosList() async {
    photoList = await API.getMovieImage();
   // log(photoList.first.toString());
    notifyListeners();
  }*/
}
