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

  static testApi(String genre) async {
    // final res = await tmdb.v3.networks.getImages(networkId);
    // log(res.toString());
  }
/*
  static getMovieById(String movieId){}
*/
/*
  /// get category images
  static Future<List<String>> getMovieImage() async {
    List<String> photosList = [];
    const pexelsUrl = 'https://api.pexels.com/v1/search';
    const apiKey =
        '563492ad6f91700001000001e386ced37ce24f0bba8e9db72a117295'; // Replace with your own API key from Pexels
    final dio = Dio();
    final response = await dio.get(pexelsUrl,
        queryParameters: {'query': 'movie', 'per_page': 20},
        options: Options(headers: {'Authorization': apiKey}));

    if (response.statusCode == 200) {
      final data = response.data;
      //  log("-----> $data   <-------");
      final photos = data['photos'];
      List temp = photos;
      temp.forEach((element) {
        photosList.add(element['src']['small']);
        log(element['src']['small']);
      });
      return photosList;
    } else {
      throw Exception('Failed to load image');
    }
  }*/

  /// get movie by genre
  static getMovieByGenre(String genre) async {
    List<MovieModel> movies = <MovieModel>[];
    movies.clear();
    final res = await tmdb.v3.discover.getMovies(withGenres: genre);
    List<dynamic> list = res["results"];
    for (var element in list) {
      movies.add(MovieModel.fromJson(element));
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
      movies.add(MovieModel.fromJson(element));
    }
    return movies;
  }
}


