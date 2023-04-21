import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/view/pages/now_playing.dart';
import 'package:moviespot/view/pages/popular_movies.dart';
import 'package:moviespot/view/pages/top_rated_movies.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.appTitle)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OutlinedButton(
                  onPressed: () {}, child: const Text("Latest Movie")),
              const TopRated(),
              OutlinedButton(
                  onPressed: () {}, child: const Text("Now Playing")),
              const NowPlaying(),
              OutlinedButton(onPressed: () {}, child: const Text("Popular")),
              const PopularMovies(),
            ],
          ),
        ),
      ),
    );
  }
}
