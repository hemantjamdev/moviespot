
import 'package:flutter/material.dart';

import '../../model/screen_shot_model.dart';

Widget buildScreenShots(ScreenShotModel images) {
  return SizedBox(
    height: 200,
    child: GridView.count(
      crossAxisCount: 3,
      children: images.backdrops!.map((screenshot) {
        return Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(screenshot),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    ),
  );
}