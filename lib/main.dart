import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/local_storage/data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'movie_spot_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);
  Hive.registerAdapter(FavDataModelAdapter());
  await Hive.openBox<FavDataModel>(Strings.database);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const MovieSpot()));
}
