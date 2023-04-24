import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviespot/model/movie_details_model.dart';
import 'package:moviespot/provider/search_provider.dart';
import 'package:moviespot/view/widgets/poster.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../constants/strings.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, SearchProvider provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: provider.searchController,
                  decoration: const InputDecoration(hintText: 'Search movies'),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      provider.searchMovie(provider.searchController.text);
                    } else if (provider.searchController.text.isEmpty) {
                      provider.clearList();
                    }
                  },
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      provider.searchMovie(provider.searchController.text);
                    } else if (provider.searchController.text.isEmpty) {
                      provider.clearList();
                    }
                  },
                ),
              ),
            ),
          ),
          body: provider.movieModel.isNotEmpty
              ? ListView.builder(
                  itemCount: provider.movieModel.length,
                  itemBuilder: (context, int index) {
                    MovieModel movie = provider.movieModel[index];
                    return searchCard(movie);
                  })
              : SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Lottie.asset("assets/animation/search.json"),
                ),
        );
      },
    );
  }
}

Widget searchCard(MovieModel movie) {
  return Card(
    elevation: 5,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30.h,
          width: 50.w,
          // margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    Strings.imageBase + movie.posterPath.toString()),
                fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                child: Text(
                  movie.title.toString(),
                  maxLines: 2,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    movie.voteAverage.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                movie.releaseDate.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
