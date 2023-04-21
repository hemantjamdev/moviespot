import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/api.dart';

import '../model/now_playing_model.dart';

class NowPlayingProvider extends ChangeNotifier {
  NowPlayingModel nowPlayingModel = NowPlayingModel();

  getNowPlaying() async {
    Map<dynamic, dynamic> res = await API.tmdb.v3.movies.getNowPlaying();
    nowPlayingModel = NowPlayingModel.fromJson(res as Map<String, dynamic>);
    notifyListeners();
  }
}
