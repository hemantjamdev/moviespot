import 'package:flutter/material.dart';
import 'package:moviespot/model/movie_model.dart';
import 'package:moviespot/provider/popular_provider.dart';
import 'package:moviespot/view/pages/view_all_page.dart';
import 'package:moviespot/view/widgets/poster.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({super.key});

  handleNavigate(BuildContext context, List<MovieModel> movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewAll(movies: movie, title: "Popular Movies"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PopularProvider>(
        builder: (context, PopularProvider provider, child) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              handleNavigate(context, provider.movieModel);
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "view all",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: provider.movieModel.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, int index) {
                      MovieModel movie = provider.movieModel[index];
                      return Poster(movie: movie);
                    })
                : const SizedBox(),
          ),
        ],
      );
    });
  }
}
