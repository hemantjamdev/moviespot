import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmer({required double height, required double width}) {
  return Shimmer(
    period: const Duration(seconds: 2),
    gradient: LinearGradient(
      colors: [Colors.grey, Colors.grey[100]!, Colors.grey[500]!],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.repeated,
    ),
    direction: ShimmerDirection.ltr,
    child: Container(
      height: height,
      width: width,
      color: Colors.grey,
    ),
  );
}
