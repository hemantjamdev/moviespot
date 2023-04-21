import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../model/popular_model.dart';

class PopularProvider extends ChangeNotifier {
  PopularModel popularModel = PopularModel();

  getPopular() async {
    Map<dynamic, dynamic> res = await API.tmdb.v3.movies.getPopular();
    popularModel = PopularModel.fromJson(res as Map<String, dynamic>);
    notifyListeners();
  }
}
