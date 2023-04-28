
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

Widget buildBackButton(BuildContext context) {
  return Positioned(
    top: 40,
    left: 16,
    child: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(8),
        child: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.white,
        ),
      ),
    ),
  );
}