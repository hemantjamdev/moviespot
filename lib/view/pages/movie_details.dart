import 'dart:developer';

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
    Provider.of<MovieDetailsProvider>(context, listen: false)
        .getCasting(widget.movie.id!);
    return Scaffold(
      appBar: AppBar(title: Text(widget.movie.title.toString())),
      body: Container(
        child: Consumer<MovieDetailsProvider>(
          builder: (context, MovieDetailsProvider provider, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: widget.heroTag,
                    child: Image.network(
                      Strings.imageBase + widget.movie.posterPath.toString(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 150,
                      child: provider.casts.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: provider.casts.length,
                              itemBuilder: (context, int index) {
                                Cast cast = provider.casts[index];
                                //   log(cast.profilePath.toString());
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          Strings.imageBase +
                                              cast.profilePath.toString()),
                                    ),
                                    Center(
                                      child: Text(cast.name!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1),
                                    )
                                  ],
                                );
                              })
                          : SizedBox(),
                    ),
                  ),
                  Text(widget.movie.popularity.toString()),
                  Text(widget.movie.releaseDate.toString()),
                  Text(widget.movie.voteAverage.toString()),
                  //Text(movie.),
                  Text("Plot Details : ${widget.movie.overview.toString()}"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
