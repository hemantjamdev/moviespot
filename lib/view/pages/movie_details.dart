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
              posterUrl: Strings.imageBase + widget.movie.posterPath!,
              title: widget.movie.title!,
              plot: widget.movie.overview!,
              genre: widget.movie.originalLanguage!,
              rating: widget.movie.voteAverage!.toString(),
              releaseDate: widget.movie.releaseDate!,
              cast: provider.casts,
              crew: provider.casts,
              screenshots: const []);
        },
      ),
    );
  }
}

class MovieDetailsPage extends StatelessWidget {
  final String posterUrl;
  final String title;
  final String plot;
  final String genre;
  final String rating;
  final String releaseDate;
  final List<Cast> cast;
  final List<Cast> crew;
  final List<dynamic> screenshots;

  const MovieDetailsPage({
    Key? key,
    required this.posterUrl,
    required this.title,
    required this.plot,
    required this.genre,
    required this.rating,
    required this.releaseDate,
    required this.cast,
    required this.crew,
    required this.screenshots,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Image.network(posterUrl),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    title,
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
                  'Release date: $releaseDate',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rating: $rating',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Genre: $genre',
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
                  plot,
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
                    itemCount: crew.length,
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
