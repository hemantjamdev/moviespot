import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviespot/model/movie_detail_model.dart';
import 'package:moviespot/provider/favorite_provider.dart';
import 'package:moviespot/view/pages/movie_details.dart';
import 'package:moviespot/view/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../local_storage/data_model.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoriteProvider>(
        builder: (context, FavoriteProvider provider, child) {
          return ValueListenableBuilder(
            valueListenable:
                Hive.box<FavDataModel>(Strings.database).listenable(),
            builder: (context, Box<FavDataModel> box, widget) {
              return box.isNotEmpty
                  ? SizedBox(
                      child: ListView.builder(
                        itemCount: box.values.length,
                        itemBuilder: (context, int index) {
                          FavDataModel favDataModel =
                              box.values.toList()[index];
                          return FutureBuilder(
                            future: provider.getMovieById(favDataModel.movieId),
                            builder: (context,
                                AsyncSnapshot<MovieDetailsModel> snapshot) {
                              if (snapshot.hasData) {
                                return movieCard(context, snapshot.data!);
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Text("please try again"),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: shimmer(height: 30.h, width: 100.w),
                                );
                              }
                            },
                          );
                        },
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Lottie.asset(Strings.favoriteImage),
                          ),
                        ),
                        const Text("Your Favorites will be listed here ")
                      ],
                    );
            },
          );
        },
      ),
    );
  }
}

movieCard(BuildContext context, MovieDetailsModel movie) {
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
    child: Card(
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 40.w,
                  child: Text(
                    movie.overview.toString(),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Consumer<FavoriteProvider>(
                  builder: (context, FavoriteProvider provider, child) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      width: 40.w,
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            provider.removeFav(movie.id!);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
