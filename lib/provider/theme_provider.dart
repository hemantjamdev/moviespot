import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class AppTheme extends ChangeNotifier {
  bool isDarkTheme = false;
  ThemeData appTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.openSans().fontFamily,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.white,
    ),
  );

  ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.openSans().fontFamily,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.white,
    ),
  );
  ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.openSans().fontFamily,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.black,
    ),
  );

 void changeTheme(bool dark) {
    if (dark) {
      appTheme = darkTheme;
      isDarkTheme = true;
    } else {
      appTheme = lightTheme;
      isDarkTheme = false;
    }
    notifyListeners();
  }
}
