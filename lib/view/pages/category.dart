import 'package:flutter/material.dart';
import 'package:moviespot/constants/strings.dart';
import 'package:moviespot/provider/category_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/loading.dart';
import '../widgets/movie_card_list.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Provider.of<CategoryProvider>(context, listen: false).getPhotosList();
    return Scaffold(
      body: GridView.builder(
        itemCount: Strings.categories.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchByGenre(
                    genreName: Strings.categories[index],
                  ),
                ),
              );
            },
            child: Card(
              child: Consumer<CategoryProvider>(
                builder: (context, CategoryProvider provider, child) {
                  return MovieCard(
                    posterUrl: Strings.imageList[index],
                    movieName: Strings.categories[index],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String posterUrl;
  final String movieName;

  const MovieCard({
    Key? key,
    required this.posterUrl,
    required this.movieName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Image.network(
            posterUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
            loadingBuilder: (context, child, loadingProgress) {
              return loadingProgress == null
                  ? child
                  : shimmer(width: 500, height: 500);
            },
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                movieName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchByGenre extends StatelessWidget {
  final String genreName;

  const SearchByGenre({Key? key, required this.genreName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false)
        .getMovieByGenre(genreName.toLowerCase());

    return Scaffold(
      appBar: AppBar(title: Text(genreName)),
      body: SizedBox(
        child: Consumer<CategoryProvider>(
          builder: (context, CategoryProvider provider, child) {
            return provider.movieModel.isNotEmpty
                ? movieCardList(provider.movieModel)
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
