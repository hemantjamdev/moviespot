/*
import 'package:flutter/material.dart';
import 'package:moviespot/model/movie_model.dart';
import 'package:moviespot/provider/latest_provider.dart';
import 'package:moviespot/view/pages/view_all_page.dart';
import 'package:moviespot/view/widgets/loading.dart';
import 'package:moviespot/view/widgets/poster.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LatestMovies extends StatelessWidget {
  const LatestMovies({super.key});

  handleNavigate(BuildContext context, List<MovieModel> movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewAll(movies: movie, title: "Latest Movies"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LatestProvider>(
      builder: (context, LatestProvider provider, child) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                handleNavigate(context, provider.movieModel);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
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
              height: 35.h,
              child: provider.movieModel.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, int index) {
                        MovieModel movie = provider.movieModel[index];
                        return Poster(movie: movie);
                      },
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: shimmer(height: 30.h, width: 50.w),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
*/
