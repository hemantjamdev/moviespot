import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviespot/model/cast_model.dart';
import 'package:moviespot/model/video_model.dart';
import 'package:moviespot/provider/movie_detail_provider.dart';
import 'package:moviespot/view/pages/search_by_genre.dart';
import 'package:moviespot/view/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../constants/strings.dart';
import '../../model/movie_detail_model.dart';
import '../../model/screen_shot_model.dart';
import '../../provider/favorite_provider.dart';
import '../widgets/genre_chips.dart';
import '../widgets/youtube.dart';

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
    Provider.of<MovieDetailsProvider>(context, listen: false)
        .getVideos(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FavoriteProvider>(context, listen: false)
        .checkForFav(widget.movieId);
    return Scaffold(
      floatingActionButton: Consumer<FavoriteProvider>(
        builder: (context, FavoriteProvider provider, child) {
          return FloatingActionButton(
            child: Icon(
              Icons.favorite,
              color: provider.isFav ? Colors.red : Colors.white,
            ),
            /*FutureBuilder(
              future: provider.checkForFav(widget.movieId),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ?
                    : Icon(Icons.favorite);
              },
            ),*/
            onPressed: () async {
              await provider.checkForFav(widget.movieId)
                  ? provider.removeFav(widget.movieId)
                  : provider.addFav(widget.movieId);
            },
          );
        },
      ),
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
                  videos: provider.videos,
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
  final List<Video> videos;

  const MovieDetailsPage(
      {super.key,
      required this.movie,
      required this.cast,
      required this.crew,
      required this.images,
      required this.videos});

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
                      fit: BoxFit.cover,
                    ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                //margin: const EdgeInsets.all(20),
                width: 90.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        movie.title.toString(),
                        style: TextStyle(
                          fontSize: 24.sp,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        playVideo(context, videos.first.key ?? "");
                      },
                      child: SizedBox(
                        height: 15.h,
                        width: 15.w,
                        child: Lottie.asset(
                          Strings.playButton,
                          animate: false,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
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
              const Text("Original Title : ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                movie.title ?? "",
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 8),
              const Text(
                'Release date: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                ' ${movie.releaseDate}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text('Rating: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              //  const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 5),
                  Text(movie.voteAverage.toString()),
                  const SizedBox(height: 8),
                ],
              ),

              const Text('Genre: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              movie.genres != null
                  ? buildGenre(context, movie)
                  : const SizedBox(),
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
              const Text(
                'video clips:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              buildVideoClips(),
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

  SizedBox buildVideoClips() {
    return SizedBox(
      height: 15.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (BuildContext context, int index) {
          return videoWidget(
              context, videos[index].key ?? "", videos[index].name ?? "");
        },
      ),
    );
  }

  InkWell videoWidget(BuildContext context, String videoId, [String? name]) {
    return InkWell(
      onTap: () {
        playVideo(context, videoId);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        color: Colors.black,
        width: 15.h,
        child: Stack(
          children: [
            Lottie.asset(Strings.playButton, animate: false),
            Text(
              name ?? "",
              style: TextStyle(fontSize: 10.sp, color: Colors.white),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> playVideo(BuildContext context, String videoId) {
    return showDialog(
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: YouTube(videoId: videoId),
          );
        });
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
