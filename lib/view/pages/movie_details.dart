import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:moviespot/model/cast_model.dart';
import 'package:moviespot/provider/movie_detail_provider.dart';
import 'package:moviespot/view/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../constants/strings.dart';
import '../../model/movie_detail_model.dart';
import '../../model/screen_shot_model.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;
  final Key heroTag;

  const MovieDetails({Key? key, required this.movieId, required this.heroTag})
      : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    Provider.of<MovieDetailsProvider>(context, listen: false)
        .getCasting(widget.movieId);
    Provider.of<MovieDetailsProvider>(context, listen: false)
        .getImages(widget.movieId);
    Provider.of<MovieDetailsProvider>(context, listen: false)
        .getMovieDetail(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieDetailsProvider>(
        builder: (context, MovieDetailsProvider provider, child) {
          return FutureBuilder(
            future: provider.getMovieDetail(widget.movieId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MovieDetailsPage(
                  movie: provider.movieDetailsModel,
                  cast: provider.casts,
                  crew: provider.crew,
                  images: provider.screenShotModel,
                );
              } else {
                return shimmer(height: 70.h, width: 100.w);
              }
            },
          );
        },
      ),
    );
  }
}

class MovieDetailsPage extends StatelessWidget {
  final MovieDetailsModel movie;
  final List<Cast> cast;
  final List<Crew> crew;
  final ScreenShotModel images;

  const MovieDetailsPage(
      {super.key,
      required this.movie,
      required this.cast,
      required this.crew,
      required this.images});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 70.h,
              width: 100.w,
              child: movie.posterPath == null
                  ? shimmer(height: 70.h, width: 100.w)
                  : Image.network(
                      Strings.imageBase + movie.posterPath.toString(),
                    ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(16),
                child: Text(
                  movie.title.toString(),
                  style: TextStyle(
                    fontSize: 24.sp,
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
              //const SizedBox(height: 8),
              const Text('Genre: ', style: TextStyle(fontSize: 16)),
              movie.genres != null ? buildGenre() : const SizedBox(),
              // const SizedBox(height: 16),
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
                height: 18.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cast.length,
                  itemBuilder: (BuildContext context, int index) {
                    return cast[index].profilePath != null
                        ? buildCastCrew(
                            imageUrl: cast[index].profilePath ?? "",
                            name: cast[index].name ?? "")
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
                height: 18.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: crew.length,
                  itemBuilder: (BuildContext context, int index) {
                    return crew[index].profilePath != null
                        ? buildCastCrew(
                            imageUrl: crew[index].profilePath ?? "",
                            name: crew[index].name ?? "")
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
              images.backdrops != null ? buildScreenShots() : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox buildGenre() {
    return SizedBox(
      height: 8.h,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: movie.genres?.length,
          itemBuilder: (context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Chip(
                label: Text(
                  movie.genres![index].name.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }),
    );
  }

  Widget buildCastCrew({required String imageUrl, required String name}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10.h,
            height: 10.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(Strings.imageBase + imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 10.h,
            child: Text(
              name,
              style: TextStyle(fontSize: 8.sp),
              overflow: TextOverflow.visible,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildScreenShots() {
    return SizedBox(
      height: 200,
      child: GridView.count(
        crossAxisCount: 3,
        children: images.backdrops!.map((screenshot) {
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
    );
  }
}
