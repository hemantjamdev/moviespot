import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title:Text("Title")),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Lottie.asset("assets/animation/favorite.json"),
              ),
            ),
            Text("Your Favorites will be listed here ")
          ],
        )
    );
  }
}
