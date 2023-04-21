import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/view/pages/home_page.dart';

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
    return MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}
