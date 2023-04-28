import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../model/movie_model.dart';

class SearchProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<MoviesListModel> movieModel = <MoviesListModel>[];

  void clearList() {
    movieModel.clear();
    notifyListeners();
  }

  void searchMovie(BuildContext context, String movieName) async {
    movieModel = await API.getSearchMovie(context, movieName);
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
