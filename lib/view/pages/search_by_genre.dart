import 'package:flutter/material.dart';
import 'package:moviespot/provider/category_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_card_list.dart';

class SearchByGenre extends StatelessWidget {
  final String genreName;

  const SearchByGenre({Key? key, required this.genreName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false)
        .getMovieByGenre(context, genreName.toLowerCase());

    return Scaffold(
      appBar: AppBar(title: Text(genreName)),
      body: SizedBox(
        child: Consumer<CategoryProvider>(
          builder: (context, CategoryProvider provider, child) {
            return provider.movieModel.isNotEmpty
                ? movieCardList(context, provider.movieModel)
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
