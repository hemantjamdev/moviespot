import 'package:flutter/material.dart';
import 'package:moviespot/constants/colors.dart';

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: AppColors.red,
      duration: Duration(seconds: 2),
    ),
  );
}
