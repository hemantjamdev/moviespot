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

  /// get personDetails
  static getPersonDetails(int id)async{
    return await tmdb.v3.people.getDetails(id);
  }

  /// get recommended movies
  static getRecommended(int movieId) async {
    List<MoviesListModel> movies = <MoviesListModel>[];
    movies.clear();
    final res = await tmdb.v3.movies.getRecommended(movieId);
    List<dynamic> list = res["results"];
    for (var element in list) {
      movies.add(MoviesListModel.fromJson(element));
    }
    return movies;
  }

  /// get movie by genre
  static getMovieByGenre(String genre) async {
    List<MoviesListModel> movies = <MoviesListModel>[];
    movies.clear();
    final res = await tmdb.v3.discover.getMovies(withGenres: genre);
    List<dynamic> list = res["results"];
    for (var element in list) {
      movies.add(MoviesListModel.fromJson(element));
    }
    return movies;
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
  static Future<List<MoviesListModel>> getSearchMovie(String movieName) async {
    List<MoviesListModel> movies = <MoviesListModel>[];
    final res = await tmdb.v3.search.queryMovies(movieName);
    List<dynamic> list = res["results"];
    for (var element in list) {
      movies.add(MoviesListModel.fromJson(element));
    }
    return movies;
  }

  /// get cast and credits(crew/casts) by movie id
  static Future<CastModel> getCasting(int movieId) async {
    final res = await tmdb.v3.movies.getCredits(movieId);
    return CastModel.fromJson(res as Map<String, dynamic>);
  }

  /// get movie list by category
  static Future<List<MoviesListModel>> getMovieList(String type) async {
    List<MoviesListModel> movies = <MoviesListModel>[];
    late Map<dynamic, dynamic> res;
    try {
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
    } catch (e) {
      log(e.toString());
    }
    List<dynamic> list = res["results"];
    for (var element in list) {
      movies.add(MoviesListModel.fromJson(element));
    }
    return movies;
  }
}
