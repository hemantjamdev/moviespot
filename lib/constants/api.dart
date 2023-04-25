import 'dart:developer';

import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/model/movie_model.dart';
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

  static testApi() async {
    final res = await tmdb.v3.movies.getVideos(238);
    log(res.toString());
  }

  /// get youtube video clips
  static Future<List> getVideos(int movieId) async {
    final res = await tmdb.v3.movies.getVideos(movieId);
    List<dynamic> list = res["results"];
    return list;
  }

  /// get movie details
  static getMovieDetails(int movieId) async {
    return await tmdb.v3.movies.getDetails(movieId);
  }

  /// get movie images
  static getMovieImages(int movieId) async {
    return await tmdb.v3.movies.getImages(movieId);
  }

  /// get movie by searched name
  static Future<List<MovieModel>> getSearchMovie(String movieName) async {
    List<MovieModel> movies = <MovieModel>[];
    final res = await tmdb.v3.search.queryMovies(movieName);
    List<dynamic> list = res["results"];
    for (var element in list) {
      movies.add(MovieModel.fromJson(element));
    }
    return movies;
  }

  /// get cast and credits(crew/casts) by movie id
  static Future<CastModel> getCasting(int movieId) async {
    final res = await tmdb.v3.movies.getCredits(movieId);
    return CastModel.fromJson(res as Map<String, dynamic>);
  }

  /// get movie list by category
  static Future<List<MovieModel>> getMovieList(String type) async {
    List<MovieModel> movies = <MovieModel>[];
    late Map<dynamic, dynamic> res;
    switch (type) {
      /// now playing
      case Strings.nowPlaying:
        res = await tmdb.v3.movies.getNowPlaying();
        break;

      /// up-coming
      case Strings.upComing:
        res = await tmdb.v3.movies.getUpcoming();
        break;

      /// popular
      case Strings.popular:
        res = await tmdb.v3.movies.getPopular();
        break;

      /// top rated
      case Strings.topRated:
        res = await tmdb.v3.movies.getTopRated();
        break;
    }
    List<dynamic> list = res["results"];
    for (var element in list) {
      movies.add(MovieModel.fromJson(element));
    }
    return movies;
  }
}
