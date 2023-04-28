import 'package:flutter/material.dart';
import 'package:moviespot/model/movie_model.dart';
import 'package:moviespot/view/pages/view_all_page.dart';
import 'package:moviespot/view/widgets/poster.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/upcoming_provider.dart';
import '../widgets/loading.dart';

class UpComing extends StatelessWidget {
  const UpComing({super.key});

  handleNavigate(BuildContext context, List<MoviesListModel> movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewAll(movies: movie, title: "Up-Coming"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UpComingProvider>(
        builder: (context, UpComingProvider provider, child) {
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
                    "Up-Coming",
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
                      MoviesListModel movie = provider.movieModel[index];
                      return Poster(movie: movie);
                    })
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
    });
  }
}
