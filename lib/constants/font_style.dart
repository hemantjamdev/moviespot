import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:moviespot/constants/colors.dart';
import 'package:sizer/sizer.dart';

class AppTextStyle {
  static  TextStyle bodyTextStyle =
      TextStyle(color: AppColors.white, fontSize: 16.sp);
  static TextStyle titleTextStyle =
      TextStyle(color: AppColors.white, fontSize: 22.sp);

  static TextStyle customTextStyle() {
    return TextStyle();
  }
}
