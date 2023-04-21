import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/model/now_playing_model.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../provider/now_playing_provider.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NowPlayingProvider>(
      builder: (context, NowPlayingProvider provider, child) {
        return SizedBox(
          height: 300,
          width: 700,
          child: provider.nowPlayingModel.results != null
              ? ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.nowPlayingModel.results!.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        "${Strings.imageBase}${provider.nowPlayingModel.results![index].posterPath}",
                      ),
                    );
                  },
                )
              : const SizedBox(),
        );
      },
    );
  }
}
