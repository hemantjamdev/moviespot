import 'package:flutter/material.dart';
import 'package:moviespot/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmer({required double height, required double width}) {
  return Shimmer(
    period: const Duration(seconds: 2),
    gradient: LinearGradient(
      colors: [
        AppColors.grey,
        AppColors.grey.withOpacity(0.1),
        AppColors.grey.withOpacity(0.5),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.repeated,
    ),
    direction: ShimmerDirection.ltr,
    child: Container(
      height: height,
      width: width,
      color: AppColors.grey,
    ),
  );
}
