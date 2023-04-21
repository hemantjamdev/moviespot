import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/provider/popular_provider.dart';
import 'package:moviespot/provider/top_rated_provider.dart';
import 'package:moviespot/utils/inernet_connectivity.dart';
import 'package:moviespot/view/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'provider/now_playing_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MovieSpot());
}

class MovieSpot extends StatelessWidget {
  const MovieSpot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<NowPlayingProvider>(
            create: (context) => NowPlayingProvider(),
          ),
          ChangeNotifierProvider<PopularProvider>(
            create: (context) => PopularProvider(),
          ),
          ChangeNotifierProvider<TopRatedProvider>(
            create: (context) => TopRatedProvider(),
          ),
          ChangeNotifierProvider<ConnectivityProvider>(
            create: (context) => ConnectivityProvider(),
          ),
        ],
        child: MaterialApp(
          title: Strings.appTitle,
          theme: ThemeData(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        ));
  }
}
