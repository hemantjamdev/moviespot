import 'package:flutter/material.dart';
import 'package:moviespot/constants/colors.dart';

Widget buildRating({required String rating}) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.star, color: AppColors.amber),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.white),
        ),
      ],
    ),
  );
}
