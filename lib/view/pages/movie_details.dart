// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:moviespot/model/cast_model.dart';
import 'package:moviespot/model/movie_details_model.dart';
import 'package:moviespot/provider/movie_detail_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/strings.dart';

class MovieDetails extends StatefulWidget {
  final MovieModel movie;
  final Key heroTag;

  const MovieDetails({Key? key, required this.movie, required this.heroTag})
      : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    super.initState();
    Provider.of<MovieDetailsProvider>(context, listen: false)
        .getCasting(widget.movie.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieDetailsProvider>(
        builder: (context, MovieDetailsProvider provider, child) {
          return MovieDetailsPage(
            movie: widget.movie,
            cast: provider.casts,
          );
        },
      ),
    );
  }
}

class MovieDetailsPage extends StatelessWidget {
  MovieModel movie;
  List<Cast> cast;

  MovieDetailsPage({required this.movie, required this.cast});

  List<dynamic> screenshots = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Image.network(Strings.imageBase + movie.posterPath.toString()),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    movie.title.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Release date: ${movie.releaseDate}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rating: ${movie.voteAverage}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Genre: ${movie.genreIds}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Plot:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie.overview.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Cast:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cast.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cast[index].profilePath != null
                          ? Column(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(Strings.imageBase +
                                          cast[index].profilePath.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  cast[index].name!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            )
                          : const SizedBox();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Crew:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cast.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cast[index].profilePath != null
                          ? Column(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(Strings.imageBase +
                                          cast[index].profilePath.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  cast[index].name!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            )
                          : const SizedBox();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Screenshots:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: screenshots.map((screenshot) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(screenshot),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
