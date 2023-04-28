import 'package:flutter/material.dart';
import 'package:moviespot/view/pages/search_by_genre.dart';
import 'package:sizer/sizer.dart';
import '../../model/movie_detail_model.dart';

Widget buildGenre(BuildContext context, MovieDetailsModel movie) {
  return SizedBox(
    height: 8.h,
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: movie.genres?.length,
      itemBuilder: (context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchByGenre(
                          genreName: movie.genres![index].name ?? "")));
            },
            child: Chip(
              label: Text(
                movie.genres![index].name.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      },
    ),
  );
}
