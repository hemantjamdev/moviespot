import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class AppTheme {
  static  ThemeData darkTheme = ThemeData(
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
}
