import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviespot/model/movie_model.dart';
import 'package:moviespot/provider/search_provider.dart';
import 'package:moviespot/view/pages/movie_details.dart';
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
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(color: Colors.purple, width: 3)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                  child: TextField(
                    controller: provider.searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search movies',
                      border: InputBorder.none,
                    ),
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
              provider.movieModel.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: provider.movieModel.length,
                        itemBuilder: (context, int index) {
                          MovieModel movie = provider.movieModel[index];
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetails(
                                      movieId: movie.id!,
                                      heroTag: UniqueKey(),
                                    ),
                                  ),
                                );
                              },
                              child: searchCard(movie));
                        },
                      ),
                    )
                  : Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Lottie.asset(Strings.searchImage),
                      ),
                    ),
            ],
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
              SizedBox(
                width: 40.w,
                child: Text(
                  movie.title.toString(),
                  maxLines: 2,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
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
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                movie.releaseDate.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 44.w,
                child: Text(
                  movie.overview.toString(),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
