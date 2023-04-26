import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moviespot/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<FavoriteProvider>(
            builder: (context, FavoriteProvider provider, child) {
      return provider.movieIdList.isNotEmpty
          ? ValueListenableBuilder(
              valueListenable: Hive.box('settings').listenable(),
              builder: (context, box, widget) {
                return Switch(
                    value: box.get('darkMode'),
                    onChanged: (val) {
                      box.put('darkMode', val);
                    });
              },
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Lottie.asset(Strings.favoriteImage),
                  ),
                ),
                const Text("Your Favorites will be listed here ")
              ],
            );
    }));
  }
}
