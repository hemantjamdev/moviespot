import 'package:flutter/material.dart';
import 'package:moviespot/view/pages/now_playing.dart';
import 'package:moviespot/view/pages/popular_movies.dart';
import 'package:moviespot/view/pages/top_rated_movies.dart';
import 'package:sizer/sizer.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Search(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Now Showing",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            NowPlaying(),
           /* Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Rated",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "view all",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ),*/
            TopRated(),

            PopularMovies(),
          ],
        ),
      ),
    );
  }
}
