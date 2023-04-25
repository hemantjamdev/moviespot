import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'movie_spot.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const MovieSpot()));
}
