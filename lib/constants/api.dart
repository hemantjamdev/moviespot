import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/model/movie_details_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../model/cast_model.dart';

class API {
  static TMDB tmdb = TMDB(
    ApiKeys(Strings.apiKeyV3, Strings.readAccessToken),
    logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
        showUrlLogs: true,
        showInfoLogs: true,
        showWarningLogs: true),
  );

  static getMovieImages(int movieId) async {
    final res = await tmdb.v3.movies.getImages(movieId);
  }

  static Future<CastModel> getCasting(int movieId) async {
    final res = await tmdb.v3.movies.getCredits(movieId);
    return CastModel.fromJson(res as Map<String, dynamic>);
  }

  static Future<List<MovieModel>> getMovieList(String type) async {
    List<MovieModel> movies = <MovieModel>[];
    switch (type) {
      /// now playing
      case Strings.nowPlaying:
        Map<dynamic, dynamic> res = await tmdb.v3.movies.getNowPlaying();
        List<dynamic> list = res["results"];
        for (var element in list) {
          movies.add(MovieModel.fromJson(element));
        }
        return movies;

      /// popular
      case Strings.popular:
        Map<dynamic, dynamic> res = await tmdb.v3.movies.getPopular();
        List<dynamic> list = res["results"];
        for (var element in list) {
          movies.add(MovieModel.fromJson(element));
        }
        return movies;

      /// top rated
      case Strings.topRated:
        Map<dynamic, dynamic> res = await tmdb.v3.movies.getTopRated();
        List<dynamic> list = res["results"];
        for (var element in list) {
          movies.add(MovieModel.fromJson(element));
        }
        return movies;
      default:
        return movies;
    }
  }
}
