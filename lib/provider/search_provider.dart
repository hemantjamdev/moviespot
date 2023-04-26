import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../model/movie_model.dart';

class SearchProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<MovieModel> movieModel = <MovieModel>[];

  clearList() {
    movieModel.clear();
    notifyListeners();
  }

  searchMovie(String movieName) async {
    movieModel = await API.getSearchMovie(movieName);
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
