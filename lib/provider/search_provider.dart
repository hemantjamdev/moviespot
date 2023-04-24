import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../model/movie_details_model.dart';

class SearchProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  // Future<List<String>> future = Future(() => null);
  // bool isSearching = false;
  // List<String> movies = ["test 1", "test2 ", "test3"];
  List<MovieModel> movieModel = <MovieModel>[];

  clearList() {
    movieModel.clear();
    notifyListeners();
  }

  searchMovie(String movieName) async {
    movieModel = await API.getSearchMovie(movieName);
    notifyListeners();
  }
}
