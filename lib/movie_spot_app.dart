import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/provider/favorite_provider.dart';
import 'package:moviespot/provider/movie_detail_provider.dart';
import 'package:moviespot/provider/person_provider.dart';
import 'package:moviespot/provider/popular_provider.dart';
import 'package:moviespot/provider/recommended_provider.dart';
import 'package:moviespot/provider/search_provider.dart';
import 'package:moviespot/provider/top_rated_provider.dart';
import 'package:moviespot/utils/inernet_connectivity.dart';
import 'package:moviespot/provider/theme_provider.dart';
import 'package:moviespot/view/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'provider/category_provider.dart';
import 'provider/now_playing_provider.dart';
import 'provider/upcoming_provider.dart';

class MovieSpot extends StatelessWidget {
  const MovieSpot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NowPlayingProvider>(
            create: (context) => NowPlayingProvider(context)),
        ChangeNotifierProvider<PopularProvider>(
            create: (context) => PopularProvider(context)),
        ChangeNotifierProvider<TopRatedProvider>(
            create: (context) => TopRatedProvider(context)),
        ChangeNotifierProvider<ConnectivityProvider>(
            create: (context) => ConnectivityProvider()),
        ChangeNotifierProvider<MovieDetailsProvider>(
            create: (context) => MovieDetailsProvider()),
        ChangeNotifierProvider<SearchProvider>(
            create: (context) => SearchProvider()),
        ChangeNotifierProvider<FavoriteProvider>(
            create: (context) => FavoriteProvider()),
        ChangeNotifierProvider<AppTheme>(create: (context) => AppTheme()),
        ChangeNotifierProvider<PersonProvider>(
            create: (context) => PersonProvider()),
        ChangeNotifierProvider<RecommendedProvider>(
            create: (context) => RecommendedProvider()),
        ChangeNotifierProvider<UpComingProvider>(
            create: (context) => UpComingProvider(context)),
        ChangeNotifierProvider<CategoryProvider>(
            create: (context) => CategoryProvider()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return Consumer<AppTheme>(builder: (context, AppTheme theme, child) {
            return MaterialApp(
              title: Strings.appTitle,
              theme: theme.appTheme,
              debugShowCheckedModeBanner: false,
              home: const HomePage(),
            );
          });
        },
      ),
    );
  }
}
