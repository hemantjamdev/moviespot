import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moviespot/view/pages/movie_details.dart';
import 'package:moviespot/view/widgets/rating.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants/strings.dart';
import '../../model/movie_model.dart';
import '../../provider/now_playing_provider.dart';
import '../widgets/loading.dart';

class NowPlaying extends StatelessWidget {
  NowPlaying({super.key});

  final CarouselController _controller = CarouselController();
  final Key heroKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<NowPlayingProvider>(
      builder: (context, NowPlayingProvider provider, child) {
        return provider.movieModel.isNotEmpty
            ? Stack(
                children: [
                  CarouselSlider(
                    items: provider.movieModel
                        .map((e) => InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetails(
                                      movieId: e.id!, heroTag: heroKey),
                                ),
                              );
                            },
                            child: SliderImage(movie: e)))
                        .toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        height: 300,
                        viewportFraction: 1.0,
                        enlargeFactor: 0.3,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          provider.changeIndex(index);
                        }),
                  ),
                  Positioned(
                    bottom: 20,
                    child: AnimatedSmoothIndicator(
                      activeIndex: provider.index,
                      count: provider.movieModel.length,
                      effect: const ScrollingDotsEffect(
                          spacing: 10, dotHeight: 15, dotWidth: 15),
                    ),
                  )
                ],
              )
            : shimmer(height: 30.h, width: 100.w);
      },
    );
  }
}

class SliderImage extends StatelessWidget {
  final MovieModel movie;

  const SliderImage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(Strings.imageBase + movie.backdropPath!),
          )),
      child: Stack(
        children: [
          buildRating(rating: movie.voteAverage.toString()),
          Positioned(
            bottom: 30,
            right: 16,
            child: Text(
              movie.title!.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
