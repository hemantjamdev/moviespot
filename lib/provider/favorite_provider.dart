import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviespot/constants/api.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/local_storage/data_model.dart';
import 'package:moviespot/model/movie_detail_model.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteProvider() {
    getFavIdList();
  }

  bool isFav = false;
  List<int> movieIdList = [];
  MovieDetailsModel movieDetailsModel = MovieDetailsModel();

  Future<MovieDetailsModel> getMovieById(int movieId) async {
    final res = await API.getMovieDetails(movieId);
    return movieDetailsModel =
        MovieDetailsModel.fromJson(res as Map<String, dynamic>);
  }

  void addFav(int movieId) async {
    Box<FavDataModel> box = await Hive.openBox<FavDataModel>(Strings.database);
    FavDataModel favDataModel = FavDataModel(movieId: movieId);
    box.put(movieId, favDataModel);
    checkForFav(movieId);
  }

  getFavIdList() async {
    Box<FavDataModel> box = await Hive.openBox<FavDataModel>(Strings.database);
    for (var element in box.keys) {
      movieIdList.add(element);
    }
  }

  void removeFav(int key) async {
    Box<FavDataModel> box = await Hive.openBox<FavDataModel>(Strings.database);
    box.delete(key);
    checkForFav(key);
  }

  Future<bool> checkForFav(int key) async {
    Box<FavDataModel> box = await Hive.openBox<FavDataModel>(Strings.database);
    isFav = box.containsKey(key);
    notifyListeners();
    return isFav;
  }
}
